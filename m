To: llandre <r&d@wawnet.biz>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Walnut configuration (old problem) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 20 Dec 2002 13:33:23 +0100."
             <5.1.1.6.0.20021220132028.02337438@dns.struinfo.it>
Date: Fri, 20 Dec 2002 16:09:33 +0100
Message-Id: <20021220150938.BA16EC6139@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <5.1.1.6.0.20021220132028.02337438@dns.struinfo.it> you wrote:
>
> I've just start working with the Walnut board. I downloaded:
> 1) linuxppc_2_4 with rsync
> 2) linuxppc_2_4_devel with rsync
> 3) linuxppc_2_4_devel with bk
>
> but in all cases I encountered the same problem described here
> http://lists.linuxppc.org/linuxppc-embedded/200207/msg00005.html.

Did you remember to set (in the top level Makefile) the definition of
ARCH to "ppc"?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
You are only young once, but you can stay immature indefinitely.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
