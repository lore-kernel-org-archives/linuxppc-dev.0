Date: Mon, 19 Jun 2000 15:29:12 -0700 (PDT)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: Michel Dänzer <daenzerm@student.ethz.ch>
cc: linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Subject: Re: ATI Mach64 support in XFree86 4.0 update...
In-Reply-To: <394DD724.D5E44BE0@student.ethz.ch>
Message-ID: <Pine.LNX.4.10.10006191525540.29493-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 19 Jun 2000, Michel [iso-8859-1] Dänzer wrote:

> If you happen to have a 4.0b version of the driver (what version is the one in
> your FTP dir?), I'd be happy to make it available for people to test with my
> experimental tarballs.

The driver currently in my dir on devel is from a 4.0d tree.  You're free
to use it but with 4.01 release around the corner I was going to wait a
bit and slap it into howarth's rpms.

> Does the driver use/need FBDev?

Currently it requires FBDev because I was too lazy to set the modes
directly.  However, I will end up removing this requirement soon.


> Does it need PCI patches on some machines?

I don't know, I didn't have to apply any kernel patches for my machine.



ani


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
