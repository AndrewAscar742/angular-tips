# Guia Completo: Configuração e Desenvolvimento em Angular

Este guia detalha o processo completo desde a configuração inicial do ambiente até a criação e utilização de componentes e serviços em um projeto Angular.

## 📌 Pré-requisitos

- Angular CLI instalado (`npm install -g @angular/cli`)
- Node.js (recomendado v20+)
- npm (recomendado v10+)

---

## 🚀 Inicialização do Projeto Angular

### 1. Configuração Inicial (SetPolicy)

Antes de criar o projeto Angular, pode ser necessário configurar a política de execução do PowerShell para permitir scripts locais e remotos:

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

### 2. Criação do Projeto

Execute o comando abaixo para criar um projeto Angular com rotas e componentes independentes (standalone):

```bash
ng new nome-do-projeto --routing --standalone
```

---

## 🔧 Estrutura do Projeto

```
src/
├── app/
│   ├── components/
│   ├── services/
│   └── models/
```

---

## 🧩 Criação de Componentes

Para criar um componente standalone:

```bash
ng generate component components/nome-componente --standalone
```

### Exemplo Básico de Componente

```typescript
@Component({
  selector: 'app-exemplo',
  standalone: true,
  templateUrl: './exemplo.component.html',
  styleUrls: ['./exemplo.component.css']
})
export class ExemploComponent {
  titulo = 'Componente Exemplo';
}
```

---

## 🔌 Criação e Uso de Serviços

Serviços facilitam a comunicação HTTP e o compartilhamento de lógica:

```bash
ng generate service services/nome-servico
```

### Exemplo de Serviço HTTP

```typescript
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Usuario } from '../models/usuario.model';

@Injectable({ providedIn: 'root' })
export class UsuarioService {

  private apiUrl = 'https://api.exemplo.com/usuarios';

  constructor(private http: HttpClient) {}

  listarUsuarios(): Observable<Usuario[]> {
    return this.http.get<Usuario[]>(this.apiUrl);
  }
}
```

### Consumindo o Serviço em um Componente

```typescript
export class ExemploComponent implements OnInit {
  usuarios: Usuario[] = [];

  constructor(private usuarioService: UsuarioService) {}

  ngOnInit() {
    this.usuarioService.listarUsuarios()
      .subscribe(data => this.usuarios = data);
  }
}
```

---

## 🔐 Implementação de Guards

Guards protegem rotas com base em autenticação ou regras específicas:

### Criar um AuthGuard

```bash
ng generate guard guards/auth --implements CanActivate
```

### Exemplo de AuthGuard básico

```typescript
@Injectable({ providedIn: 'root' })
export class AuthGuard implements CanActivate {

  constructor(private authService: AuthService) {}

  canActivate(): boolean {
    return this.authService.estaAutenticado();
  }
}
```

### Aplicar Guard em uma Rota

```typescript
export const routes: Routes = [
  { path: 'protegido', component: ProtegidoComponent, canActivate: [AuthGuard] }
];
```

---

## ✅ Recomendações Finais

- Organize claramente os componentes e serviços.
- Siga a estrutura de pastas sugerida.
- Sempre configure corretamente as políticas do ambiente antes de iniciar um projeto.
- Utilize tipagem forte em TypeScript para melhorar a manutenção e qualidade do código.
