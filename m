From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15331.5645.328862.515166@cargo.ozlabs.ibm.com>
Date: Sat, 3 Nov 2001 08:54:21 +1100 (EST)
To: Roman Zippel <zippel@linux-m68k.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: APUS irq patch
In-Reply-To: <Pine.LNX.4.33.0111020007080.8971-100000@serv>
References: <Pine.LNX.4.33.0111020007080.8971-100000@serv>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Roman,

> This patch converts the irq assembly in head.S into C, the only problem is
> that I needed to change a prototype in <linux/irq.h>, as some additional
> info has to be saved/restored during an irq.

Could you describe for us how the APUS interrupt stuff works?  In
looking at your patch, I found myself thinking "there's got to be a
better way" but before making any suggestions I want to make sure I
understand what is being done and why.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
