Message-ID: <6DF87017DA95D611AC6000606730DE9B0BD70F@BLREXSR>
From: Sanjeev Manral <sanjeevm@sanyo.co.in>
To: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: pcmcia memory resource
Date: Sat, 24 Aug 2002 20:57:39 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi all,

I'm trying to port PCMCIA card services to linux-ppc(IBM Powerpc 405).
I've to give memory and  port IO resource in /etc/pcmcia/config.opts

Port I/O i ve given from pcmcia gpio resister's value.
I donot know what value to assign for memory resources. I've tried many
combinations, nothing is working.

If somebody knows where to find these memory address please let me know.

Thanks
Sanjeev


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
