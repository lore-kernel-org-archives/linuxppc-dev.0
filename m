Date: Thu, 20 Sep 2001 15:22:46 -0800
From: Ethan Benson <erbenson@alaska.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org,
	Debian PowerPC <debian-powerpc@lists.debian.org>, dan@debian.org
Subject: Re: [ANN] yaboot maintainer change
Message-ID: <20010920152246.B14835@plato.local.lan>
References: <20010920150939.32251@smtp.adsl.oleane.com>
Mime-Version: 1.0
In-Reply-To: <20010920150939.32251@smtp.adsl.oleane.com>; from benh@kernel.crashing.org on Thu, Sep 20, 2001 at 05:09:39PM +0200
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Sep 20, 2001 at 05:09:39PM +0200, Benjamin Herrenschmidt wrote:
> Hi all !
>
> The maintenance of yaboot releases & packaging will now be handled by
> Ethan Benson. He should shortly release 1.3 (which is the same as 1.2.5
> code wise for those who caught it), the version bump is here to avoid
> confusion with versions I released.
>
> The archives of older versions on my page will remain, users should
> however now get their versions from Ethan, I'll let him explain that all.

Basically the main goal of this is to merge ybin and yaboot into a
single unified source tree.  In the past yaboot contained virtually no
documentation and no userland installation and configuration tools,
those were only part of the ybin distribution.  Now both ybin and
yaboot are part of the same source tree, which I will call yaboot.

The distribution pages will be:

http://www.alaska.net/~erbenson/yaboot

and http://penguinppc.org/usr/yaboot

the old ~erbenson/ybin and /usr/ybin links will continue to work
indefinitly, you will however get the exact same page (they are just
symlinks now).

Before ybin-X.Y.Z.tar.gz required no compilation since ybin is writtin
in sh rather then C, now that this is a single tree containing yaboot,
you will have to compile the source to get binaries, if this is
impossible i have also provided a binary tarball dist
yaboot-binary-X.Y.Z.tar.gz.  I highly recommend compiling and
installing from the source tarball over the binary tarball however.

the source tree is in the yaboot-1.3.tar.gz tarball, precompiled
binary dist is in yaboot-binary-1.3.tar.gz

Distributions who have in the past distributed separate ybin and
yaboot packages should merge them into a single yaboot package.

As I have done in the past these tarballs are signed with my GnuPG
key, verifying these signatures is as always highly recommended.

The current web page is still mostly the same as the ybin page, I will
eventually redo this, and probably rewrite the README (which is also
pretty much just ybin's).  these are non-technical merging issues
however.

I have released version 1.3, it's available at the above URLs.  I will
probably release a 1.3.1 within the next day or two to change a couple
aspects about the binary dist tarball (don't include ./etc/yaboot.conf).

comments and suggestions are welcome, flames should go to /dev/null.

Enjoy.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
