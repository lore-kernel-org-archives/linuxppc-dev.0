Date: Wed, 18 Dec 2002 17:11:46 +0100 (CET)
From: Marius Groeger <mag@sysgo.de>
To: Allen Curtis <acurtis@onz.com>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: make module_install 
In-Reply-To: <NCBBIINEHIPFGJPLBEIFGEEOEAAA.acurtis@onz.com>
Message-ID: <Pine.LNX.4.40.0212181706560.11319-100000@mag.devdep.sysgo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 18 Dec 2002, Allen Curtis wrote:

> I think I have followed this thread to the end and I don't see a solution to
> the module problem? If that is the case, I noticed in the original message
> that ARCH=ppc was specified but the CROSS_COMPILE= was not. ARCH really only
> affects make menuconfig. (from my experience) But if you do not specify the
> correct compiler you will definitely get complaints about not having a
> compatible architecture.

I think the solution was given quite early by Jaap-Jan Boor: use the
Busybox depmod Perl script, if you need one.

Regards
Marius

-----------------------------------------------------------------------------
Marius Groeger           SYSGO Real-Time Solutions AG       mgroeger@sysgo.de
Software Engineering     Embedded and Real-Time Software    www.sysgo.de
Voice: +49-6136-9948-0   Am Pfaffenstein 14                 www.osek.de
FAX:   +49-6136-9948-10  55270 Klein-Winternheim, Germany   www.elinos.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
