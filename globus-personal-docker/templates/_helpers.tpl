{{- define "globus-personal-docker.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "globus-personal-docker.fullname" -}}
{{- include "globus-personal-docker.name" . -}}
{{- end -}}