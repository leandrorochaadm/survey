# SignUp presenter

## Regras
1. ✅ Chamar Validation ao alterar o email
2. ✅ Notificar o emailErrorStream com o mesmo erro do Validation, caso retorne erro
3. ✅ Notificar o emailErrorStream com null, caso o Validation não retorne erro
4. ✅ Não notificar o emailErrorStream se o valor for igual ao último
5. ✅ Notificar o isFormValidStream após alterar o email
6. Chamar Validation ao alterar a senha
7. Notificar o passwordErrorStream com o mesmo erro do Validation, caso retorne erro
8. Notificar o passwordErrorStream com null, caso o Validation não retorne erro
9. Não notificar o passwordErrorStream se o valor for igual ao último
10. Notificar o isFomrValidStream após alterar a senha
11. Chamar Validation ao alterar o nome
12. Notificar o nameErrorStream com o mesmo erro do Validation, caso retorne erro
13. Notificar o nameErrorStream com null, caso o Validation não retorne erro
14. Não noficar o nameErrorStream se o valor for igual ao último
15. Notificar o isFormValidStream após alterar o nome
16. Chamar Validation ao alterar a confirmação de senha
17. Notificar o passwordConfirmationErrorStream com o mesmo erro do Validation, caso retorne erro
18. Noficar o passwordConfirmationErrorStream se o valor for igual ao último
19. Não notificar o passwordConfirmationErrorStream se o valor for igual ao último
20. Notificar o isFormValidStream após altera a confirmação de senha
