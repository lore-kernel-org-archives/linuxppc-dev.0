Message-ID: <19991130234159.8771.qmail@web1004.mail.yahoo.com>
Date: Tue, 30 Nov 1999 15:41:59 -0800 (PST)
From: Dan Bethe <dan_bethe@yahoo.com>
Subject: Re: 2.3.29 - Wallstreet MediaBays
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	I have the same symptom with my Wallstreet 233 MHz
and a pre-built 2.2.10 kernel.  I don't remember where
the kernel came from but it might have been from BenH.
	I seem to remember hot-swapping working just
perfectly fine at some point in the past.  Before this
kernel, I used the "very stable powerbook" kernel
distributed with R5.
	Here are the conditions:

* cdrom works indefinately, even if I pull it out and
reinsert it
* I can remove my cdrom, and insert a floppy drive.
* Once I hot-swap in the floppy drive, the floppy only
works for one operation.  After that, it says
"/dev/fd0: no such device".  I can mount once, or I
can use 'mtools' once.  Then the floppy drive
disappears from sight.
* floppy would have only worked once even when I just
cold booted with it in.
* The instant I remove the floppy drive, the whole
machine instantly powers off.

	I'll be upgrading my kernel with BenH's 2.2.13pb
kernel RSN(tm)!  I know my kernel is old.  I just
thought I'd contribute some keystrokes to the
discussion.

--- Joseph Garcia <jpgarcia@execpc.com> wrote:
> 
> Is anyone else having problems with hot-swapping
> media bays using 2.3.29?  Im
> using Paul's Linuxcare rsync from a few days ago.
> 
> Symptom: kernel panic upon hot swapping cdrom drive
> into media bay.
> (wallstreet2-300MHz)


=====
"Don't expect your own messiah; this neverworld which you desire is
only in your mind." -- http://www.dreamtheater.net/songb4.htm#IV5

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
