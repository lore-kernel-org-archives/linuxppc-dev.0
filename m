Date: Fri, 3 Nov 2000 15:52:09 +0100 (CET)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Albrecht Dreﬂ <ad@mpifr-bonn.mpg.de>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard Sleep Crash (Was: 2.2.18pre17 again)
In-Reply-To: <3A02C77B.1F113D1@mpifr-bonn.mpg.de>
Message-ID: <Pine.LNX.4.10.10011031533270.14593-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > When did you last rsync? I got my latest source yesterday afternoon, and
> > have no problems whatsoever...
>
> I rsync'ed again AND compiled the kernel with the original, unmodified .config.
> Again, /dev/adb could not be opened, and modprobe complains about the missing
> module for char-major-56. So I am totally lost...

Is there a file adb.o in drivers/macintosh/ ?? Do you find adb_init and
adb_open in System.map?

I don't see any differences between my working .config and BenH's that
would accunt for this. I don't see any differences between pre14 and pre17
that count, for that matter. (There's some change to the low level sleep
code but that should affect both your and my Lombard alike.)

Now all this assumes you're not using BootX - I haven't tried pre17 with
BootX yet.

> > You didn't accidentially delete /dev/adb?
>
> Nope:
> crw-r--r--    1 root     root      56,   0 Apr 30  1999 /dev/adb

Just checking the obvious :-)

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
