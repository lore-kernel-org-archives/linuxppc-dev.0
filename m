Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id CE052DDF0C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Apr 2007 02:13:43 +1000 (EST)
Message-ID: <461BB78D.5080401@ovro.caltech.edu>
Date: Tue, 10 Apr 2007 09:13:01 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Gary Kenaley <gkenaley@echelon.com>
Subject: Re: Unable to Boot 2.6.19.2 from ELDK 4.1 on MPC8349E MDS
References: <BAY115-W6F965CAAC5215961F494FB2590@phx.gbl>
	<DDBD7B17DB2ECE48BCD94C593F7255B4046E9F23@monk.echelon.echcorp.com>
In-Reply-To: <DDBD7B17DB2ECE48BCD94C593F7255B4046E9F23@monk.echelon.echcorp.com>
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

Gary Kenaley wrote:
> I have been evaluating Freescale 2.6.11, Wind River 2.6.14, and am now
> attempting Denx 2.6.19 (from ELDK 4.1) - running on the Rev 1.0 MPC8349E
> MDS (V1.1 CPU). I boot 2.6.19.2 using the factory u-boot 1.1.3 and the
> kernel immediately hangs:

Hey Gary,

I'm working with the same board (and have a rev 3.0 EA board too).
Here are my notes for the ELDK 4.0;

http://www.ovro.caltech.edu/~dwh/powerpc_mpc8349e.pdf

I setup the board so the software developers could start working
with it, so haven't touched it for a while ... (the instructions
use the arch/ppc version) ...

So, try repeating via the arch/ppc method, and follow Ben's
arch/powerpc advice and let us know how things went.

If you're having trouble, then I hope to get back to working
with the board soon, so I can also take a crack at repeating
Ben's arch/powerpc method.

Cheers,
Dave
