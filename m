Message-ID: <3B7DA593.E10E4E71@mvista.com>
Date: Fri, 17 Aug 2001 18:15:31 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: "Dr. Craig Hollabaugh" <craig@hollabaugh.com>
Cc: Mark Pilon <mark.pilon@minolta-qms.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: init fails w/ new build of gcc & glibc
References: <3B7D82D5.DD98A109@minolta-qms.com>
	 <5.1.0.14.0.20010817160848.00abfec0@spudcentral.com> <5.1.0.14.0.20010817164756.00ab8b40@spudcentral.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> To summarize for me (and others), "leave kernel parameters as they stand" means
>
> CONFIG_MATH_EMULATION=y and compile with -msoft-float

If the kernel source uses -msoft-float leave it, if it does not leave
it.. ;)  Don't fool with kernel CFLAGS unless you _REALLY_ know what you
are doing.

--Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
