Message-ID: <19991124005625.A7469@lx.c-side.com>
Date: Wed, 24 Nov 1999 00:56:25 -0800
From: Neil Russell <caret@c-side.com>
To: Dan Malek <dmalek@jlc.net>, LiuTao <tliu@ict.ac.cn>
Cc: linuxppc <linuxppc-dev@lists.linuxppc.org>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: need suggestions
References: <3839F122.3BF6FEDF@ict.ac.cn> <383A0E2D.CFACF894@jlc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <383A0E2D.CFACF894@jlc.net>; from Dan Malek on Mon, Nov 22, 1999 at 10:46:53PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Nov 22, 1999 at 10:46:53PM -0500, Dan Malek wrote:
> How do you load vxWorks?  I have worked on several vxWorks projects,

If you use vxWorks to load Linux, you would probably still have to pay
WindRiver a royalty.  Also, that would make the worlds largest bootloader;
well ok, OF is larger.

Many years ago, I wrote a boot loader that does (amongst other things)
BOOTP and TFTP.  I plan to port it to PPC for a project I'm doing soon
and I will publish it.  It wont be ready for a few months though.


-- 
Neil Russell <caret@c-side.com>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
