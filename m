Reply-To: <lourens@mecalc.co.za>
From: "LC Geldenhuys" <lourens@mecalc.co.za>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Kernel Mode Software Emulation NIP: 00001FFC - cache coherency problem on m8xx processors
Date: Fri, 26 Mar 2004 09:23:52 +0200
Message-ID: <002401c41303$4dae8890$8702a8c0@lcgnotebook>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20040325231357.GA22460@logos.cnet>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org] On Behalf
> Of Marcelo Tosatti
> Sent: 26 March 2004 01:14 AM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: Kernel Mode Software Emulation NIP: 00001FFC - cache
> coherency problem on m8xx processors

<snip>

> I'm not exactly sure why we were jumping to "1FFC" instead of "2000",
> but adding "isync" before "bl transfer_to_handler" in both
> DecrementTimer
> and HardwareInterrupt fixed the problem for us.

This sounds distinctly familiar to the CPU13 Errata. Do you have
Instruction fetch show cycles enabled in ICTRL[IST_SER]? See:
http://e-www.motorola.com/files/32bit/doc/errata/MPC860CE.pdf

Cheers,
  Lourens


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
