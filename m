From: Daniel Wu <Daniel.Wu@alcatel.com.au>
Subject: Re: Porting LinuxPPC
To: linuxppc-embedded@lists.linuxppc.org
Message-Id: <00May30.174931est.115248@border.alcanet.com.au>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <20000519051051.236093C972@elph.research.canon.com.au>
 <39253A48.24B90117@snmc.com> <39253D0B.F9AF86EE@raleigh.ibm.com>
 <392562CE.A71A4F49@embeddededge.com> <392A3147.3A9AC5C2@alcatel.com.au>
Date: Tue, 30 May 2000 17:49:30 +1000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm still having problems with booting the kernel - I've got to the point where the
compressed image has been successfully decompressed and starts to execute code in
kernel/head.S, which sets up the TLBs. However, as soon as the code turns on the
mmu, the code crashes!

I'm running this under a BDM monitor, could this be the source of the problem? One
thing I noticed is that the kernel uses virtual addresses starting at c0000000 and
the BDM monitor fails to do the translation. Is there any way to get around this?

Thanks in advance.

Regards,
Daniel


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
