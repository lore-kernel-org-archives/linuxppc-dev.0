To: Dan Malek <dan@embeddededge.com>
Cc: OTAVIO ISAMU SUGENO <otavio.sugeno@siemens.com.br>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: How to configure 2 ethernet devices 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 15 May 2002 12:00:19 EDT."
             <3CE28613.8090206@embeddededge.com>
Date: Wed, 15 May 2002 20:31:28 +0200
Message-Id: <20020515183133.3A6101196A@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

in message <3CE28613.8090206@embeddededge.com> Dan Malek wrote:
>
> The purpose of IP-Config is to provide a minimal network configuration
> as to allow a network booting feature.  It will not completely initialize
> a network environment suitable for little more than the NFS connection itself.

...but it comes in very handy for embedded systems  that  don't  need
the  overhead  (memory  footprint) for tools like ifconfig and route.
And for most simple configurations (where you just  need  to  set  IP
address, netmask, and default router) it is completely sufficient.

> > IP-Config: Got RARP answer form 10.0.0.10, my address is 10.0.0.100
> >
> > I guess this is to the eth0 interface.
>
> The IP-Config sends requests on all configured interfaces and accepts the
> first one that replies.

You can restrict the chioce of interfaces  by  using  an  "ip="  boot
argument.

> You need to run the real user-land network configuration scripts and utilities
> to properly configure a network on any system.  It should also be done even
> when you are using IP-Config and network booting.

Ummm... what for? I never do this, and the systems are  just  working
fine.  I  never  saw any deficiency in the IP autoconfiguration stuff
(except that it doesn't accept more than one "ip=" option, so we  can
configure only one interface that way). What am I missing?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Out of register space (ugh)"
- vi

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
