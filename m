To: Marco Schramel <Schramel.Linux@go.bartec.de>
Cc: "PPC_LINUX" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Init hangs 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 05 Aug 2004 11:54:54 +0200."
             <200408051154.54426.Schramel.Linux@go.bartec.de>
Date: Thu, 05 Aug 2004 12:33:19 +0200
Message-Id: <20040805103324.9CA4EC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200408051154.54426.Schramel.Linux@go.bartec.de> you wrote:
>
> my kernel hangs by initializing the system. My target is mpc8270-based. I use ELDK 3.0 and mount my root-fs over nfs.
> Denx-kernel 2.4.25.
...
> It seems like it hangs in "run_init_process("/sbin/init");" or the /sbin/init - file does not work.
> Sometimes the message "INIT: version 2.84 booting" is showed. And after printing this message it hangs, too.
> But the most times it looks like above.
>
> Any ideas?

Run ethereal and have a look at  the  network  traffic.  Check  which
files get loaded and/or accessed. This might give you an idea.

But first check your memory map. Kernels crashing when entering  user
space   are   often   an  indication  of  illegal  memory  maps.  See
http://www.denx.de/twiki/bin/view/PPCEmbedded/Kernel#Section_10.2.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
How much net work could a network work, if a network could net work?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
