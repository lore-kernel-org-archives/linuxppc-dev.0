In-Reply-To: <19991130234159.8771.qmail@web1004.mail.yahoo.com>
Date: Wed, 1 Dec 1999 15:16:06 +0100
To: Dan Bethe <dan_bethe@yahoo.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: 2.3.29 - Wallstreet MediaBays
Message-Id: <19991201151606.027764@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Nov 30, 1999, Dan Bethe <dan_bethe@yahoo.com> wrote:

>	I have the same symptom with my Wallstreet 233 MHz
>and a pre-built 2.2.10 kernel.  I don't remember where
>the kernel came from but it might have been from BenH.
>	I seem to remember hot-swapping working just
>perfectly fine at some point in the past.  Before this
>kernel, I used the "very stable powerbook" kernel
>distributed with R5.
>	Here are the conditions:
>
>* cdrom works indefinately, even if I pull it out and
>reinsert it
>* I can remove my cdrom, and insert a floppy drive.
>* Once I hot-swap in the floppy drive, the floppy only
>works for one operation.  After that, it says
>"/dev/fd0: no such device".  I can mount once, or I
>can use 'mtools' once.  Then the floppy drive
>disappears from sight.
>* floppy would have only worked once even when I just
>cold booted with it in.
>* The instant I remove the floppy drive, the whole
>machine instantly powers off.
>
>	I'll be upgrading my kernel with BenH's 2.2.13pb
>kernel RSN(tm)!  I know my kernel is old.  I just
>thought I'd contribute some keystrokes to the
>discussion.

I suggest you try my 2.2.14pre9 rev.7 (the kernel for iBooks & co.). I
made some changes & fixes for wallstreet as well. However, it appears
that the floppy driver is not very robust and you may still experience
some troubles with it (not directly related to the fact that the floppy
is in the media bay). The shutdown is a typical symptom of a crash on
PowerBooks. Sometimes, you end up in the debugger, sometimes, it just
shuts down (if there was communication with the PMU in progress when it
crashed, xmon won't always correctly take over, I don't know why yet).

I'll try to look into the floppy driver when I find sometimes, my todo
list is already quite full (if someone else plans to fix the floppy
driver, please tell me).

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
