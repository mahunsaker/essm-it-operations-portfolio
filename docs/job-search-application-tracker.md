# Automated Job Search & Application Tracker

## Overview

This portfolio project demonstrates an automated workflow for discovering IT job opportunities, assessing technical alignment, separating opportunities by work arrangement, preventing duplicate application activity, and maintaining a structured Excel application pipeline.

The production workflow uses authenticated job-search and email integrations. This public documentation is intentionally sanitized: it contains no credentials, connector identifiers, personal email addresses, private application history, or live job-search data.

## Business Problem

Job searches across multiple sources can create duplicate listings, inconsistent notes, missed follow-ups, and repeated applications. The workflow addresses those problems by normalizing discovered opportunities into a single tracking model and retaining application history between runs.

## Workflow

```text
Job Search Source        Job Alert Email
       |                       |
       +-----------+-----------+
                   |
                   v
             Job Discovery
                   |
                   v
          Relevance Assessment
                   |
                   v
             Deduplication
                   |
                   v
       Work-Arrangement Classification
          /                     \
     Remote                On-Site/Hybrid
          \                     /
           +---------+---------+
                     |
                     v
              Excel Tracker
                     |
                     v
          Application Pipeline
```

## Target Role Families

The workflow is designed to identify positions such as:

- Network Engineer / Network Administrator
- Systems Engineer / Systems Administrator
- Infrastructure Engineer
- Linux Administrator
- Windows / Active Directory administration
- Virtualization and Proxmox-related roles
- IT Support / Service Desk
- Desktop and endpoint support
- Related infrastructure and technical operations positions

## Processing Logic

### Skills Alignment

Each useful opportunity receives an alignment assessment based on overlap between the posting and relevant technical experience. Examples of evaluated technologies include Windows, Linux, Active Directory, Microsoft 365, networking, DNS/DHCP, VPN, virtualization, PowerShell, Bash, endpoint support, ticketing, and infrastructure operations.

The percentage is a prioritization aid rather than a claim that an applicant meets a mathematically exact percentage of employer requirements.

### Duplicate Prevention

The workflow generates a stable identifier from normalized job attributes and compares new discoveries with previously tracked records. Primary duplicate indicators include:

- Employer
- Position title
- Location
- Source or job identifier
- Application URL

Previously tracked application state is preserved instead of recreating the tracker from scratch on each run.

### Work Arrangement

Results are organized into two primary queues:

1. Remote
2. On-Site / Hybrid

This makes work-arrangement filtering visible without losing a single master application history.

## Excel Tracking Model

The generated workbook uses the following logical worksheets:

| Worksheet | Purpose |
|---|---|
| Dashboard | Summary of discovered opportunities and application pipeline |
| Remote Jobs | Remote opportunities awaiting review or action |
| On-Site-Hybrid Jobs | Local, on-site, hybrid, or travel-based opportunities |
| Applications | Positions for which an application has been submitted |
| Archive | Closed, rejected, expired, duplicate, or inactive opportunities |

Tracked fields include discovery date, source, company, title, location, work type, compensation when available, alignment assessment, match notes, application link, application status, application date, resume version, cover-letter status, follow-up date, notes, and a unique deduplication identifier.

## Operational Schedule

The production implementation is designed for scheduled weekday execution with optional manual test runs. Each run discovers current opportunities, evaluates relevance, compares them with the existing history, and produces an updated workbook rather than an independent one-time report.

## Reliability Lessons

During implementation, workbook usability was validated as part of the workflow rather than assuming successful file generation meant successful delivery. Two specific improvements resulted:

- Job records were surfaced on the dashboard as well as their category worksheet so opportunities were immediately visible.
- Application destinations were implemented as native external spreadsheet hyperlinks, with the raw source URL retained as a copy/paste fallback.

These corrections illustrate an important automation principle: validate the final user-facing artifact, not only the upstream data-processing step.

## Security & Privacy

The public portfolio intentionally excludes:

- Authentication tokens and credentials
- Private email addresses
- Connector and automation identifiers
- Live application history
- Private resumes
- Personal correspondence
- Unredacted job-search exports

A public demonstration workbook should use fabricated companies, job postings, URLs, dates, and application states.

## Technologies & Concepts Demonstrated

- Scheduled workflow automation
- Multi-source information aggregation
- Structured data normalization
- Rule-based classification
- Deduplication and state preservation
- Skills-to-requirements analysis
- Excel workbook generation
- Native spreadsheet hyperlinks
- Dashboard/report generation
- Error correction and output validation
- Privacy-aware portfolio documentation

## Professional Relevance

This project demonstrates the ability to turn a repetitive information-management process into a documented, repeatable operational workflow. The same techniques apply to IT operations reporting, ticket triage, asset management, monitoring aggregation, compliance tracking, and other administrative automation problems.
