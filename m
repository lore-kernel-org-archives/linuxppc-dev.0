Message-ID: <383A0AA4.1E4227DC@mvista.com>
Date: Mon, 22 Nov 1999 19:31:48 -0800
From: Christian Zankel <chris@mvista.com>
MIME-Version: 1.0
To: Cort Dougan <cort@fsmlabs.com>, linuxppc-devel@lists.linuxppc.org,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: bootloader & head.S weirdness & restructuring
References: <19991122120429.031138@mailhost.mipsys.com> <19991122143732.B12973@hq.fsmlabs.com> <3839CF18.5D600DE@mvista.com> <19991122165535.A13360@hq.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Cort Dougan wrote:
> Not all machines.  The gemini and yellowknife don't have a bootloader.
Well, but it wouldn't hurt if it had one(?) The only scenario a
bootloader would not work is if the kernel actually runs in ROM. 

 [...lot's of descriptions how a bootloader must be designed deleted..]
> It would be ideal to have the kernel start at physical 0, with the bootinfo
> info passed along with the necessary data the bootloader has gathered.  If
> there's no bootloader then the arch specific calls can gather what they
> need.
That was exactly what I meant.

> I don't agree.  It takes some manipulation in head.S or a clever
> bootloader, though.  If you have suggestions for a simpler/cleaner system I
> would be happy to add them, though!
And of course you need to edit mm/init.c. But if you try to exclude any
code related to OF and/or residual data there are many more than just
head.S. (Try to walk along the 'path' of the 8xx implementation). I
would like to see some kind of an implementation like the m68k tree. 

> If you're doing the 82xx work we should talk before you do that too much.
> I'd like to find something that makes 8xx,6-7xx and 4xx happy before I
> start merging in large tree-changes.
I thought that Dan Mallek is working on the 82xx port. Actually, I'm
working on a custom designed board based on a 750, and it looks like
that there are two or more to come in the forseeable future. (I guess
the ports will be much like the port for the gemini board, i.e. without
OpenFirmware, and maybe other 'pecularities').

> We have something very close to that now.  What specific problems are you
> having?  I'm not disagreeing that it's a problem, I just don't see where
> the problem is.
I'm sorry. I only wanted to have mentioned that, because that seemed to
be a requirement from you, at least it was a couple of month ago.

Thanks,
Christian

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
