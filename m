To: curt brune <curt@acm.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: wireless lan PCMCIA card advice 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 06 Jan 2003 18:35:17 PST."
             <20030106183517.E24490@curtisb.com>
Date: Tue, 07 Jan 2003 09:07:13 +0100
Message-Id: <20030107080718.1BFDBC608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Curt,

in message <20030106183517.E24490@curtisb.com> you wrote:
>
> I am running ELDK 2.0.2 which does have RPMs for pcmcia-cs and
> wireless-tools.  I also see my target installation has the "iwconfig"
> program installed in /sbin.  The target also has /etc/pcmcia/* and
> /etc/rc.d/init.d/pcmcia.

OK.

> >From your email I gather all I need to do is recompile my kernel to
> include support for the wireless LAN (CONFIG_NET_RADIO) .  Is that
> correct ?

Right, but you need a  recent  kernel  (from  our  CVS).  The  kernel
specific  parts  (stuff like drivers/pcmcia/m8xx_pcmcia.c) were added
after the release of  ELDK  2.0.2  [and  some  more  extensions  like
simultaneous  support  for  both  PCMCIA  slots on MPC860 systems was
added even later].

Don't forget to run

	bash$ make modules
	bash$ make modules_install INSTALL_MOD_PATH=/opt/eldk/ppc_8xx

when building your kernel.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Of course there's no reason for it, it's just our policy.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
