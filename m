To: "Kerl, John" <John.Kerl@Avnet.com>
Cc: "'Ed Brady'" <mailinglist@ebrady.net>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Compiling 2.4.18 for Motorola MBX board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 27 Mar 2002 14:02:15 MST."
             <C08678384BE7D311B4D70004ACA371050B763357@amer22.avnet.com>
Date: Wed, 27 Mar 2002 22:08:38 +0100
Message-Id: <20020327210843.8B325109F4@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <C08678384BE7D311B4D70004ACA371050B763357@amer22.avnet.com> you wrote:
>
> The default PPC .config appears to be something that's
> appropriate to, say, running Linux on a Macintosh.

Well, the MBX is an embedded system, so you cannot really expect  the
DEFAULT configuration to work on it, right?

> You should go into make menuconfig, & de-select PMAC
> and other Mac-type ethernet devices.
>
> In fact, I made sure to go through every (!) menu,
> sub-menu, sub-sub-menu, etc. in make menuconfig to
> de-select everything that wasn't appropriate for my
> system.

Why not just chosing a working default configuration?

	$ make mbx_config
	$ make oldconfig
	$ make dep
	$ make zImage

will do the Right Thing (TM) in a blink or two...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Landing: a controlled mid-air collision with a planet.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
