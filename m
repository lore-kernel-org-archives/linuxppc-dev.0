Message-ID: <396CC00D.27D7149F@lanl.gov>
Date: Wed, 12 Jul 2000 12:59:25 -0600
From: Ben Sapp <bsapp@lanl.gov>
Reply-To: bsapp@lanl.gov
MIME-Version: 1.0
To: Lionel TAILLURAT <Lionel.TAILLURAT@ecrin.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: -= MVME 2300 =-
References: <007701bfec22$aed1c710$a66d34c0@oleane.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Lionel TAILLURAT wrote:
> So I had decided to try the MVME2600 kernel image of Gabriel Paubert, this
> one don't boot (PC keyb error, there is no keyboard controller on the
> mvme2300! ).
>
> Seeing that, I try to compile a new kernel using the kernel patch created by
> Gabriel Paubert, and the second second problem appears !
>

I am using Gabriel's patches for the MVME2301  with out any problems.
You might try specifying "console=/dev/ttyS0"  when you get to the
bootlooader prompt.(remove the double quotes)

> 2- SCSI drivers.
>

I don't understand, the MVME 2300 series does not have a SCSI
controller.  Why do you want a SCSI driver?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
