MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16592.50800.578068.287308@cargo.ozlabs.ibm.com>
Date: Thu, 17 Jun 2004 08:15:12 +1000
From: Paul Mackerras <paulus@samba.org>
To: "McMullan, Jason" <jason.mcmullan@timesys.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: FPSCR corruption
In-Reply-To: <1087409391.14878.92.camel@veena.timesys>
References: <1087409391.14878.92.camel@veena.timesys>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Oddity. I'm seeing SIGFPEs arrive in the wrong process.
>
> I'm seeing this in my 2.4.x kernels, on 8260 and 750 cpus (and anything
> else that has an FPU).

Hmmm, it doesn't fail for me, e.g. on a G4 cube (7400 cpu) running
2.4.23, or on a dual G5 running 2.6.7-rc2 ppc64.

We used to have a bug that would cause this but it got fixed quite a
while ago now.  What kernel version are you using?

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
