Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Tue, 17 Dec 2002 19:12:36 +0100 (CET)
From: Marius Groeger <mag@sysgo.de>
To: Wolfgang Denk <wd@denx.de>
Cc: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: make module_install 
In-Reply-To: <20021217173744.78C63C6139@atlas.denx.de>
Message-ID: <Pine.LNX.4.40.0212171909030.11803-100000@mag.devdep.sysgo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 17 Dec 2002, Wolfgang Denk wrote:

> different for embedded systems: modules are  usually  only  used  for
> driver  development,  and  then you will manually load and unload the
> driver anyway. I will even go so far to say that if you need  to  run
> "depmod"  for  your embedded system you should fix your system design
> because you are doing something wrong.

Someone might use loadable modules because he doesn't want to release
his driver under the GPL. I wouldn't exactly consider this wrong.

Regards,
Marius

-----------------------------------------------------------------------------
Marius Groeger           SYSGO Real-Time Solutions AG       mgroeger@sysgo.de
Software Engineering     Embedded and Real-Time Software    www.sysgo.de
Voice: +49-6136-9948-0   Am Pfaffenstein 14                 www.osek.de
FAX:   +49-6136-9948-10  55270 Klein-Winternheim, Germany   www.elinos.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
