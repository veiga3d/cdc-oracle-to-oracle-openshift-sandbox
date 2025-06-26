# CDC Oracle → Oracle com Kafka Connect no OpenShift (Sandbox)

Este projeto implementa uma solução completa de CDC usando Debezium e Kafka Connect, com deploy direto no OpenShift Sandbox.

---

## 📂 Estrutura

- `Dockerfile` e `entrypoint.sh`: imagem customizada do Kafka Connect
- `jars/`: JARs do Debezium e Oracle
- `connectors/`: JSONs de configuração dos connectors
- `sql/`: Scripts SQL para setup do Oracle
- `openshift/`:
  - `openshift-deployments.yaml`: Deploys, Services
  - `openshift-buildconfig.yaml`: BuildConfig da imagem customizada

---

## 🚀 Como Usar no OpenShift Sandbox

### 1. Suba este projeto para um repositório Git (ex: GitHub)

### 2. Acesse o terminal web do OpenShift Sandbox

```bash
oc new-project cdc-oracle
```

### 3. Crie a BuildConfig

```bash
oc apply -f openshift/openshift-buildconfig.yaml
```

### 4. Inicie o build

```bash
oc start-build kafka-connect-build
```

### 5. Aguarde o build e deploy

```bash
oc apply -f openshift/openshift-deployments.yaml
```

### 6. Verifique os pods

```bash
oc get pods
```

---

## ✅ Testes

- Após subir os pods, insira dados no Oracle Source.
- Verifique se são replicados no Oracle Sink.

--- 

