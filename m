Message-ID: <39E73DE0.F95F057F@mvista.com>
Date: Fri, 13 Oct 2000 09:52:48 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Paolo Scaffardi <arsenio@tin.it>
CC: linuxppc-emb <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PCMCIA - another step...
References: <01e301c034fb$fb1580e0$0a00010a@airvent.it>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paolo Scaffardi wrote:

I have some patches for the kernel and pcmcia-cs for the 8xx on our ftp
site.

ftp://ftp.mvista.com/pub/area51/ppc_8xx

I moved Magnus stuff up to pcmcia-cs-3.1.19 and there is a patch for the
ioremapping of _IO_BASE.  I chose 0x80000000 but that probably is not
the best place to put it.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
