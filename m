To: "Ashwin Bihari" <raz0redge@hotmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux boot args with PReP image 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 31 Oct 2003 13:28:49 EST."
             <BAY9-F64QUsi6dnG8Cq0008719d@hotmail.com>
Date: Fri, 31 Oct 2003 22:22:56 +0100
Message-Id: <20031031212301.0CE3EC59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <BAY9-F64QUsi6dnG8Cq0008719d@hotmail.com> you wrote:
>
> This, of course, means that if we decide to change the location of root, or
> more appropriately decide to have two separate roots between which we would
> have switch back and forth, I'll have to recompile the kernel with the new
> string and then put that onto the PReP partition.

This was one of the reasons why I started to develop U-Boot  (ok,  by
then the name was still PPCBoot).

> Has anyone done anything similar or have any tips for me?

Porting U-Boot to a new board is not that much work...

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
As far as we know, our computer has never had an undetected error.
		                                           -- Weisert

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
