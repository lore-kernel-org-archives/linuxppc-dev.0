Date: Thu, 17 Apr 2003 16:25:22 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: JFFS2 on the Host
In-reply-to: <20030417131517.66513.qmail@web41813.mail.yahoo.com>
To: cedric_aubert@yahoo.fr, linuxppc-embedded@lists.linuxppc.org
Reply-To: tglx@linutronix.de
Message-id: <200304171625.22677.tglx@linutronix.de>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
References: <20030417131517.66513.qmail@web41813.mail.yahoo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thursday 17 April 2003 15:15, Cedric Aubert wrote:
> Hi,
>
> I have read some documentation about jffs2 but I don't
> find what I want (may be I am to difficult !! :-).
>
> I found how configure my flash on the target and by
> the
> target.
>
> Kernel configuration OK -> Next Eraseall
> -> mount or make a jffs2 image and cp it before mount
>
> it's ok. But How can I make a full Binary Image of my
> flash partition (good size) on my host and after
> transfer it on the target at the right
> place with my loader (u-boot for example) ??

The mtd tool you need is mkfs.jffs2, which is available in the MTD source code
from http://linux-mtd.infradead.org. It's in directory utils. There is a man
page too. Be aware of endianess switches for mkfs.jffs2!

--
Thomas
________________________________________________________________________
linutronix - competence in embedded & realtime linux
http://www.linutronix.de
mail: tglx@linutronix.de


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
