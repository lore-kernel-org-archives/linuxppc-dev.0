To: "Stephan Linke" <Stephan.Linke@epygi.de>
Cc: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: running 8xx without UART 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 12 Jun 2003 09:34:08 +0200."
             <FCEAKDJJAPHPLJFINDAJAEHGDCAA.Stephan.Linke@epygi.de>
Date: Thu, 12 Jun 2003 12:04:59 +0200
Message-Id: <20030612100504.22A9FC5FD7@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <FCEAKDJJAPHPLJFINDAJAEHGDCAA.Stephan.Linke@epygi.de> you wrote:
>
> is it possible to make a 8xx kernel without setting up one of the serial interfaces for UART mode? It seames to me like it is only

Yes, this is possible.

> possible to choose between the CPM interfaces.
> We are experiencing problems with SCC3 running ethernet and SMC1 as console interface on a 852.

I think it would be better to solve this problem instead of just  not
using SMC1 and leaving an unresolved bug in the kernel...


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Immortality consists largely of boredom.
	-- Zefrem Cochrane, "Metamorphosis", stardate 3219.8

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
