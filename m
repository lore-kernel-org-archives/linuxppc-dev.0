Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ATI Radeon 32MB PCI, Apple 17 Flat panel on B+W G3
Date: Sat, 6 Oct 2001 21:28:23 -0400
References: <20011006174121.LSLQ12483.tomts13-srv.bellnexxia.net@there> <20011006181958.6089@smtp.wanadoo.fr>
In-Reply-To: <20011006181958.6089@smtp.wanadoo.fr>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Message-Id: <20011007012607.RSBA10438.tomts12-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ben,

Total failure.

It seems my setup and all 2.4.X kernels seem to hate each other.

After a few minutes using Dan Burcaw's 2.4.8 or your 2.4.6 (I want to keep
the potential to use my firewire cdrom rw), I get tons of the following
messages:

aic7xxx_abort returns 8194

(I have an extra Apple external scsi card to drive my scsi devices which
have the linux side of things).

and my bash prompt goes away and I am basically hosed.

This does not happen with the 2.2.19 kernel I have been using.

As for the ATI Radeon, it is assigned /dev/fb1 but never lights up.
It is recognized but according to dmesg but no luck actually using it.

Of course, the kernel itself barfs as above.

I have reverted to my old monitor and my old 2.2.19 kernel.

Any hints on how to attack this would be greatly appreciated!

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
