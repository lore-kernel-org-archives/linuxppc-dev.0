Date: Fri, 22 Nov 2002 17:05:01 +0100 (CET)
From: Marius Groeger <mag@sysgo.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org, <d.mueller@elsoft.ch>,
	Wolfgang Denk <wd@denx.de>, <steven.scholz@imc-berlin.de>
Subject: Re: 'pImage' and 'uImage' targets
In-Reply-To: <20021122150542.GM779@opus.bloom.county>
Message-ID: <Pine.LNX.4.40.0211221655450.4044-100000@mag.devdep.sysgo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 22 Nov 2002, Tom Rini wrote:

> Next, is it necessary to have both targets, as they produce the same
> exact output?  I can see this for 2.4 since I'm sure both work in 2.4
> and both have insturctions says to use {u,p}Image.  But will the PPCBoot

Since the U-Boot now contains our port to several ARM platforms and
the i386 port is more than upcoming, we would also need those targets
in the corresponding arch trees as well. Now how are we going to
handle _that_ without duplicating Make-code/scripts?

Regards,
Marius

-----------------------------------------------------------------------------
Marius Groeger           SYSGO Real-Time Solutions AG       mgroeger@sysgo.de
Software Engineering     Embedded and Real-Time Software    www.sysgo.de
Voice: +49-6136-9948-0   Am Pfaffenstein 14                 www.osek.de
FAX:   +49-6136-9948-10  55270 Klein-Winternheim, Germany   www.elinos.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
