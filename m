To: David Woodhouse <dwmw2@infradead.org>
Cc: jeffy <leo_guo@jisung.cn>,
	"linuxppc-embedded@lists.linuxppc" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: which is the best root File system in embed linux system? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 02 May 2004 08:42:17 BST."
             <1083483737.32758.146.camel@imladris.demon.co.uk>
Date: Sun, 02 May 2004 11:20:22 +0200
Message-Id: <20040502092027.BB675C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear David,

in message <1083483737.32758.146.camel@imladris.demon.co.uk> you wrote:
>
> > Yes, this is the logical consequence of your mis-use.
>
> For many classes of embedded system I don't consider unannounced power
> failure to be 'mis-use'. That's why we run powerfail tests on JFFS2 and

Neither do I. My "mis-use" only referred to the fact of using an ext2
filesystem in a system where powerfails are expected to happen.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Life would be so much easier if we could  just  look  at  the  source
code.                                                   -- Dave Olson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
