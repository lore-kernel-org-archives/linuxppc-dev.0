To: Silverton Aron-C1710C <Aron.J.Silverton@motorola.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Cross-compile package combinations 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 16 Dec 2003 12:53:40 CST."
             <6F8DFFA2C996D711945800065BFC9E4A03B9910C@il02exm11>
Date: Tue, 16 Dec 2003 21:14:17 +0100
Message-Id: <20031216201422.2A3FAC5F5F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <6F8DFFA2C996D711945800065BFC9E4A03B9910C@il02exm11> you wrote:
>
> I do have a another question, though.  Let's say that I want to use my own kernel instead of having crosstool download it.  What would be the proper set of steps to take to specify a local kernel?  My current kernel is 2.4.20 and I know that the combina

The steps are: download a kernel, unpack it, configure it, compile it, boot it.

Kernel and tools are more or less unrelated to each other.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I will also, for an appropriate fee, certify that  your  keyboard  is
object-oriented,  and  that  the bits on your hard disk are template-
compatible.            - Jeffrey S. Haemer in <411akr$3ga@cygnus.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
