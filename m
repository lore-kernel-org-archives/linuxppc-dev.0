Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7924467A3F
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  5 Mar 2006 15:31:07 +1100 (EST)
Message-ID: <440A696B.1060802@ovro.caltech.edu>
Date: Sat, 04 Mar 2006 20:30:35 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Ralph Blach <rcblach@blach.dnsalias.org>
Subject: Re: cross tools for the 440gp
References: <440A3FB4.6060806@blach.dnsalias.org>
In-Reply-To: <440A3FB4.6060806@blach.dnsalias.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ralph Blach wrote:
> are there any prebuild cross compilers for the 440gp processors
> that would compile a 2.6 kernel?
> 
> If so, could I get some pointer to where they are?
> 

Download the Denx ELDK 4.0 CD-ROM it has everything you need.

http://www.denx.de

http://www.denx.de/wiki/view/DULG/ELDKAvailability

http://www.denx.de/wiki/view/DULG/ELDKDownloadPowerPC

The install file tells you how to install the tools,

http://www.denx.de/wiki/view/DULG/ELDKInitialInstallation

for example, I use the 440EP which has an FPU, so
to install the tools (from the ELDK CD-ROM after
mounting the iso image)

./install -d /opt/eldk-4.0 ppc_4xxFP

you'll want

./install -d /opt/eldk-4.0 ppc_4xx

Read the Denx UBoot+Linux Guide (DULG), it'll help.

Regards,
Dave
