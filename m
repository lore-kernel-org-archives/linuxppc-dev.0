Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3BD6ADD9.64C99491@imc-berlin.de>
Date: Wed, 24 Oct 2001 14:02:33 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: laurent.pinchart@capflow.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC8xx IDE
References: <3BD6AA4D.1050502@capflow.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Laurent,

> While trying to find an easy way to add non-volatile storage on a
> custion MPC860 board, I noticed that there was some support for IDE on
> the PCMCIA interface in the Linux kernel.

There are actually at least three ways for connecting an IDE HDD. See
ide-m8xx.c:

---
  8xx_PCCARD uses the 8xx internal PCMCIA interface in combination
             with a PC Card (e.g. ARGOSY portable Hard Disk Adapter),
             ATA PC Card HDDs or ATA PC Flash Cards (example: TQM8xxL
             systems)

  8xx_DIRECT is used for directly connected IDE devices using the 8xx
             internal PCMCIA interface (example: IVMS8 systems)

  EXT_DIRECT is used for IDE devices directly connected to the 8xx
             bus using some glue logic, but _not_ the 8xx internal
             PCMCIA interface (example: IDIF860 systems)
---

I am probably the only one using EXT_DIRECT. ;-)

Drop me a line if you need schematics.

Cheers,

Steven Scholz

imc Meﬂsysteme GmbH
Voltastr. 5
13355 Berlin
Germany

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
