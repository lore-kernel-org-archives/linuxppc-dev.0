Return-Path: <gguevel@interfaceconcept.com>
Received: from smtp3.clb.oleane.net (smtp3.clb.oleane.net [213.56.31.19])
	by ozlabs.org (Postfix) with ESMTP id 0A166682F4
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Sep 2005 03:34:19 +1000 (EST)
From: =?iso-8859-1?Q?G=E9rard_Gu=E9vel?= <gguevel@interfaceconcept.com>
To: "'Andy Fleming'" <afleming@freescale.com>
Date: Tue, 27 Sep 2005 19:36:53 +0200
Message-ID: <000a01c5c38a$0f77cda0$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <5D83ECE9-90F7-4BE2-B173-C20CB868E9F6@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: How to use SPE on MPC8541
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



> You say the application runs, right?  So what made you check the SPE
> bit state?  The kernel keeps SPE disabled by default so it doesn't
> have to save the upper 32 bits of the registers every context
> switch.  When a process uses SPE for the first time, an exception is
> triggered, the kernel enables SPE for that process, and then that
> process should be able to use SPE every time it gets cpu time.
>
> How are you determining that the SPE bit is not set?  Is your
> application not executing the SPE instructions?
>
> Andy

Yes the application runs. I wrote a mini driver with an ioctl which
performs a mfmsr() call and  returns the value to the user application.
I called this ioctl at several times before and after executing SPE code.
I already tried to manually force the SPE bit with another ioctl which
performs a enable_kernel_spe() call. The bit SPE is right set at this time
but disappears later.

I don't know if using ioctls is a right way to check the bit.

Any idea ?
Thanks
Gérard
