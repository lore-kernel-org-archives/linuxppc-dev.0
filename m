To: Dan Malek <dan@embeddededge.com>
Cc: paulus@samba.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: include/asm-ppc/platforms/ 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 27 Dec 2001 09:59:59 EST."
             <3C2B376F.9070508@embeddededge.com>
Date: Wed, 28 Nov 2001 00:44:41 +0100
Message-Id: <20011127234446.79B93F9BA@denx.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <3C2B376F.9070508@embeddededge.com> you wrote:
>
> That's a pretty good idea, and I have another one.  Name the
> directory include/asm-ppc/ppc-platforms or something, then
> have a symbolic link
> 	include/asm/platform -> include/asm-ppc/ppc-platforms/<board-file>

Isn't that redundand?

IMHO "include/asm/platform -> include/asm-ppc/platforms/<board-file>"
would do just fine - I don't expect anyone to create a
include/asm-ppc/i386-platforms/ directory?


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
People with narrow minds usually have broad tongues.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
