To: "=?GB2312?Q?=D3=DA=E6=BA?=" <yuj@mail.ndsc.com.cn>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: use bdi on board with ppcbug 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 20 Dec 2002 16:34:05 +0800."
             <200212200829.CAA05221@lists.linuxppc.org>
Date: Fri, 20 Dec 2002 16:10:39 +0100
Message-Id: <20021220151044.3343AC6139@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200212200829.CAA05221@lists.linuxppc.org> you wrote:
>
>   I want to debug the kernel on the motorola lopec p011 board with bdi tools.
> And the first thing I must solve is to let the ppcbug "go" under the bdi control.But  I don't know where the entry of ppcbug is,so I can't "go" the ppcbug.Has anybody know that?Or,the ppcbug can not be run under this circumstances?

Just type "reset", followed by "go".

Like any other boot loader, ppcbug will strat right  from  the  reset
vector.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Eschew obfuscation.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
