Date: Fri, 28 Feb 2003 19:03:23 +0100 (CET)
From: Marius Groeger <mag@sysgo.de>
To: Kamaraj P <kamarajp@future.futsoft.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Information about Library Optimizer 
In-Reply-To: <000001c2df25$1a61db80$3c06140a@future.futsoft.com>
Message-ID: <Pine.LNX.4.52.0302281859120.25295@mag.devdep.sysgo.de>
References: <000001c2df25$1a61db80$3c06140a@future.futsoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 28 Feb 2003, Kamaraj P wrote:

>      Does Any body Used Library Optimizer ?
> if so , can any one  give some example how to use it ..

I have strong doubts about tools like this - amazingly well though how
it may actually do the job in a certain setup. Building a monolithic
block of software first, and then rip it apart again just doesn't seem
right to me.

> Is there any other way to reduce the library size ..

If you're really short on memory, you should consider using an
alternative library solution like uClibc.

Just my 2 cents.

Regards,
Marius

-----------------------------------------------------------------------------
Marius Groeger           SYSGO Real-Time Solutions AG       mgroeger@sysgo.de
Software Engineering     Embedded and Real-Time Software    www.sysgo.de
Voice: +49-6136-9948-0   Am Pfaffenstein 14                 www.osek.de
FAX:   +49-6136-9948-10  55270 Klein-Winternheim, Germany   www.elinos.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
