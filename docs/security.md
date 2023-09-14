# Security

## Concepts

### Terminology

Abbreviation | Meaning                                     | Links
------------ | ------------------------------------------- | -----
**CIS**      | Center for Internet Security                | [CIS Kubernetes Benchmarks](https://www.cisecurity.org/benchmark/kubernetes)
**CVE**      | Common Vulnerabilities and Exposures        | [cve.org](https://www.cve.org/)
**DLP**      | Data Loss Prevention                        | [What is DLP?](https://www.imperva.com/learn/data-security/data-loss-prevention-dlp/) (example: Social Security Number (SSN))
**DPI**      | Deep Packet Inspection                      | [What is DPI?](https://www.fortinet.com/resources/cyberglossary/dpi-deep-packet-inspection)
**eBPF**     |                                             | [ebpf.io](https://ebpf.io/), [eBPF: Put the Kubernetes Data Plane in the Kernel](https://thenewstack.io/ebpf-put-the-kubernetes-data-plane-in-the-kernel/)
**FIPS**     | Federal Information Process Standard        |
**FISMA**    | Federal Information Security Management Act |
**IAM**      | Idendity and Access Management              |
**IDS**      | Intrusion Systems                           |
**IPS**      | Intrusion Prevention Systems                |
**OWASP**    | Open Web Application Security Project       | [owasp.org](https://owasp.org/)
**OSI**      | Open Systems Interconnection                | [OSI Model Explained](https://www.youtube.com/watch?v=LANW3m7UgWs&t=13s)
**SIEM**     | Security Information and Event Managers     |
**WAF**      | Web Application Firewall                    | [What is a WAF?](https://www.cloudflare.com/learning/ddos/glossary/web-application-firewall-waf/)

### Securization logic

* Principles
    * Least privilege
    * Zero-Trust

* 3 steps of authentication security
    * Authentication
    * Authorization
    * Admission

* Network traffic
    * North-South
    * East-West

### Checklists

* [15 Point Kubernetes Security Checklist](https://containerjournal.com/editorial-calendar/rsa/15-point-kubernetes-security-checklist/) - May 5, 2021

## Tools

* [Kubescape](https://github.com/kubescape/kubescape)
* [NeuVector](neuvector/index.md)
* [OpenSCAP](https://www.open-scap.org/)

## Training

* A Cloud Guru
    * [Kubernetes Security](https://learn.acloud.guru/course/7d2c29e7-cdb2-4f44-8744-06332f47040e/dashboard)

## Additional ressources

* [The Open Cloud Vulnerability & Security Issue Database](https://www.cloudvulndb.org/)
