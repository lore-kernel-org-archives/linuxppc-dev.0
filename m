Subject: Re: Ramdisk using libc5
To: seabra@cyclades.com (Edson Ap. Seabra)
Date: Tue, 25 Jul 2000 10:41:05 +1000 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org (Linux List)
In-Reply-To: <397CBC73.4DB0233C@cyclades.com> from "Edson Ap. Seabra" at Jul 24, 2000 03:00:19 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000725004105.DDC919D@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Edson Ap. Seabra writes:
> This helps a lot. The libc now has 1.03 Mb ... I guess libc still have a lot
> of code that I don't need.  I have to find a easy way to strip them.

There is a magic script named mklibs.sh which removes unused functions from     the shared C library in the Debian Boot Floppies package, at:
    ftp://ftp.us.debian.org/debian/dists/potato/main/source/admin/boot-floppies_2.2.16.tar.gz

Let us know how you go!

Regards,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
