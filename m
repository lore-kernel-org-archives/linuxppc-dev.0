To: =?gb2312?q?Dross=20Zhou?= <zjuzhou@yahoo.com.cn>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: IDE_PCCARD vs IDE_DIRECT in mpc8xx? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 06 Jun 2002 16:39:39 +0800."
             <20020606083939.57394.qmail@web15004.mail.bjs.yahoo.com>
Date: Thu, 06 Jun 2002 10:54:07 +0200
Message-Id: <20020606085412.ECEEF102F2@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20020606083939.57394.qmail@web15004.mail.bjs.yahoo.com> you wrote:
>
> 	We want to add a ide interface to our system.We find
> there are two ways , direct on pcmcia port and using
> pccard.And we want to need a interface which can use

There are THREE ways. You can also use  an  external  IDE  interface,
independend of the 8xx PCMCIA controller.

Steven Scholz <steven.scholz@imc-berlin.de> has posted  the  hardware
design to this list some time ago.

> Who can tell me which one is better?

This depends on your requirements.

Using a PCCard adapter is nice if you want to  be  able  to  add  and
remove  the  drive;  using a direct interface requires no PCMCIA slot
and no PCCard adapter, so it's much cheaper for mass production.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Do we define evil as the absence of goodness? It seems only  logical
that shit happens--we discover this by the process of elimination."
                                                        -- Larry Wall

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
