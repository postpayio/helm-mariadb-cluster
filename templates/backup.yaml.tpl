{{- range $name, $value := .Values.backup }}
---
apiVersion: k8s.mariadb.com/v1alpha1
kind: Backup
{{ include "resourceValues" (list $name $value) }}
{{- end }}