Date: Tue, 11 Dec 2001 10:29:29 -0700 (MST)
From: Derrik Pates <dpates@dsdk12.net>
To: Ralf Weidemann <linuxppc@gatekeeper.informatik.fh-dortmund.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.17pre4-ben0: cisco aironet driver x86 only / airport roaming
 support ?
In-Reply-To: <3C16283E.90102@gatekeeper.informatik.fh-dortmund.de>
Message-ID: <Pine.LNX.4.40.0112111027140.10784-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 11 Dec 2001, Ralf Weidemann wrote:

> Should the cisco aironet driver work on ppc too or is it x86 only ?
> I can load the modules, but the card seems not to work. Supports the
> apple airport driver roaming with aironet 350 access points ? I can't
> get both working and I wonder me if it should work.

You are running pcmcia-cs, and not just loading the Card Services driver
modules outright, correct? Because that will not work - you have to run
the pcmcia-cs agent daemon (cardmgr) to handle insertion and removal
events, to configure device drivers, etc. If you are, make sure you follow
Ben's advice about updating your kernel - he recently re-fixed a PCMCIA
resource management bug in the kernel tree.

Derrik Pates      |   Sysadmin, Douglas School   |    #linuxOS on EFnet
dpates@dsdk12.net |     District (dsdk12.net)    |    #linuxOS on OPN


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
