Message-ID: <398A1BE9.BFAFDF57@cyclades.com>
Date: Thu, 03 Aug 2000 18:27:05 -0700
From: "Edson Ap. Seabra" <seabra@cyclades.com>
MIME-Version: 1.0
To: Linux List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Ramdisk using libc5
References: <20000725004105.DDC919D@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am having two problems running the  "mklibs.sh":

1) The script asks for files libxxx_pic.a and I do not know how to generate or to get them...

2) The script calls a command "readlink" that is not available  in the Red Hat Linux 6.0

Beside this I have replaced many files from the directory bin by the busybox. I could save about 0.5M.

Regards.
Edson.

Graham Stoney wrote:

> Edson Ap. Seabra writes:
> > This helps a lot. The libc now has 1.03 Mb ... I guess libc still have a lot
> > of code that I don't need.  I have to find a easy way to strip them.
>
> There is a magic script named mklibs.sh which removes unused functions from     the shared C library in the Debian Boot Floppies package, at:
>     ftp://ftp.us.debian.org/debian/dists/potato/main/source/admin/boot-floppies_2.2.16.tar.gz
>
> Let us know how you go!
>
> Regards,
> Graham
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
