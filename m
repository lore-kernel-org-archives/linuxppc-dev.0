Message-Id: <5.1.0.14.0.20010817172909.00ab9c90@spudcentral.com>
Date: Fri, 17 Aug 2001 17:29:39 -0600
To: Mark Hatle <fray@mvista.com>
From: "Dr. Craig Hollabaugh" <craig@hollabaugh.com>
Subject: Re: init fails w/ new build of gcc & glibc
Cc: Mark Pilon <mark.pilon@minolta-qms.com>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3B7DA593.E10E4E71@mvista.com>
References: <3B7D82D5.DD98A109@minolta-qms.com>
 <5.1.0.14.0.20010817160848.00abfec0@spudcentral.com>
 <5.1.0.14.0.20010817164756.00ab8b40@spudcentral.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 06:15 PM 8/17/2001 -0500, Mark Hatle wrote:
>> To summarize for me (and others), "leave kernel parameters as they stand" means
>>
>> CONFIG_MATH_EMULATION=y and compile with -msoft-float
>
>If the kernel source uses -msoft-float leave it, if it does not leave
>it.. ;)  Don't fool with kernel CFLAGS unless you _REALLY_ know what you
>are doing.


OK, you got it.  Thanks for the help, have a great weekend!


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
