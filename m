From: Ole.Reinartz@nokia.com
Message-ID: <A914533BF4B9D2118D980008C7894C0A014D54FA@dueis01nok>
To: pfb@syseng.anu.edu.au, Ole.Reinartz@nokia.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Kernel Math Emulation again
Date: Mon, 6 Dec 1999 10:15:32 +0200 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Has anyone tried writing a driver for the MPC860 CPM DSP?  
> The Motorola FAQ
> says that it can perform an 8x8 pixel Discrete Cosine 
> Transform in 30uS (@
> 25Mhz clock speed).  The MPC823 has a DSP coprocessor in it 
> as well.  The
> MPC860 DSP library is targeted for modem processing but could 
> be used for
> other purposes.  
> -- 
> Peter Brown, Software Engineer      | Phone: +61 2 6279 8830
> Robotic Systems Lab, RSISE          | Fax:   +61 2 6279 8660
> Australian National University      | 
> Canberra ACT 0200 AUSTRALIA         |
> --------------------------------------------------------------
> ------------

Peter,

I never heard of a driver especially for the CPM. But for the single
services of it there are drivers, like ethernet, SCC, SMC...
I know you can add functionality like DCT to the CPM via 'downloading'
'microcode' to it. Perhaps we could make a 'modem driver'?
There should be a very low level driver which at least manages the dual
ported ram, perhaps even virtualises the access to the data structures in it
like managing the buffer pointer allocation, localizing the register files
a.s.o.

 Ole

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
