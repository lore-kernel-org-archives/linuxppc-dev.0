Subject: Re: insmod / add-symbol-file
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Fri, 7 Dec 2001 12:24:21 +0100
Message-ID: <566C53CBBECCFF4D8D31B380F7B345FB01666A@PICARD.nc1701.de>
From: "Frank Przybylski" <fp@vas-gmbh.de>
To: "Goddeeris Frederic" <Frederic.Goddeeris@siemens.atea.be>,
	<linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Goddeeris,

> I use the gcc and gdb from the MontaVista CDK 2.0 for
> PPC_8xx. I compiled
> the module with "-O2 -g" options.

Have you tried to compile with "-O -g" options instead of "-O2 -g"?
I'd guess optimization 'confuses' gdb symbols. Maybe have a try even
without -O,
 as I only know for sure that the kernel needs an optimization step to
get some things
properly setup.

hth
 Frank

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
