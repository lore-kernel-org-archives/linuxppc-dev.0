Date: Fri, 14 May 2004 15:29:43 +0200
From: Marc Leeman <marc.leeman@barco.com>
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppc-82xx_objcopy hangs
Message-ID: <20040514132943.GI4043@smtp.barco.com>
Reply-To: Marc Leeman <marc.leeman@barco.com>
References: <20040513110725.GU4043@smtp.barco.com> <20040513161638.C3444C108D@atlas.denx.de>
Mime-Version: 1.0
In-Reply-To: <20040513161638.C3444C108D@atlas.denx.de>
Content-Type: text/plain; charset=iso-8859-15
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Seems you version of objcopy is broken. Try using the native objcopy,
> or the cross objcopy from the ELDK.

Wolfgang,

It seems you were right, your version of the GCC compiler does not
produce this problem [1], while the MVista tools do [2]. I guess it's
time to issue a bug report.

[1] [malm@bpscltpd u-boot-1.1.1]$ ppc_82xx-gcc --version
ppc_82xx-gcc (GCC) 3.2.2 20030217 (Yellow Dog Linux 3.0 3.2.2-2a_1)
Copyright (C) 2002 Free Software Foundation, Inc., in ELDK

[2] [malm@bpscltpd ppcboot]$ ppc_82xx-gcc --version
ppc_82xx-gcc (GCC) 3.3.1 (MontaVista 3.3.1-3.0.13.0400526 2004-04-16)
Copyright (C) 2003 Free Software Foundation, Inc., in MVista 3.1

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
