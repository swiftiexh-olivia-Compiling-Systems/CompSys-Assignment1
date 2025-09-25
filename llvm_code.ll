declare void @putint(i32)

define i32 @sum_array(i32 %n,i32* %arr){
%i = alloca i32,align 4 
store i32 0,i32* %i,align 4
%sum = alloca i32,align 4 
store i32 0,i32* %sum,align 4
br label %sta
sta:  
%i_value = load i32,i32* %i,align 4
%com = icmp slt i32 %i_value,%n
br i1 %com, label %whi, label %end
whi: 
%arr_addr = getelementptr inbounds i32,i32* %arr,i32 %i_value
%arr_value = load i32,i32* %arr_addr,align 4
%rem = srem i32 %arr_value,2
%even = icmp eq i32 %rem,0
br i1 %even, label %tru, label %fal
tru:
%sum_value = load i32,i32* %sum,align 4
%sum_new = add i32 %sum_value,%arr_value
store i32 %sum_new,i32* %sum,align 4
br label %inc
fal:
%sum_value1 = load i32,i32* %sum,align 4
%sum_new1 = sub i32 %sum_value1,%arr_value
store i32 %sum_new1,i32* %sum,align 4
br label %inc
inc:
%i_new = add i32 %i_value,1
store i32 %i_new,i32* %i,align 4
br label %sta
end:
%result = load i32,i32* %sum,align 4
ret i32 %result
}
define i32 @main(){
%n = alloca i32,align 4
store i32 5,i32* %n,align 4
%arr = alloca [5 x i32], align 4
%i = alloca i32,align 4
store i32 0,i32* %i,align 4
br label %str
str:
%i_value = load i32,i32* %i,align 4
%n_value = load i32,i32* %n,align 4
%cmp = icmp slt i32 %i_value,%n_value
br i1 %cmp, label %ing, label %main_end
ing:
%arr_addr = getelementptr inbounds [5 x i32], [5 x i32]* %arr, i32 0, i32 %i_value
%res = mul i32 %i_value,%i_value
store i32 %res,i32* %arr_addr,align 4
%i_new = add i32 %i_value,1
store i32 %i_new,i32* %i,align 4
br label %str
main_end:
%arr_ptr = getelementptr inbounds [5 x i32], [5 x i32]* %arr, i32 0, i32 0
%result = call i32 @sum_array(i32 %n_value, i32* %arr_ptr)
call void @putint(i32 %result)
ret i32 0
}