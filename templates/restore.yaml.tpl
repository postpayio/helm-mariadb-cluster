{{- range $name, $value := .Values.restore }}
---
apiVersion: k8s.mariadb.com/v1alpha1
kind: Restore
{{ include "resourceValues" (list $name $value) }}
{{- end }}