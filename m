Message-ID: <6F8DFFA2C996D711945800065BFC9E4A0387830D@il02exm11>
From: Silverton Aron-C1710C <Aron.J.Silverton@motorola.com>
To: "'Ashwin Bihari'" <raz0redge@hotmail.com>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Cross-compile package combinations
Date: Thu, 11 Dec 2003 08:29:36 -0600
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ashwin Bihari <mailto:raz0redge@hotmail.com> wrote:
> Aron,
>
> I've recently done just this, same host and target. I used GCC
> 3.2.3 with GLIBC 2.3.2 w/ Linuxthreads and Binutils 2.14. This
> worked fine.
>
> Check out a package called "crosstools". It's a nice tool that
> will tell you about working combinations, actaully download these
> tarballs off the web, find any applicable patches, apply them,
> configure the tools for your host and target, build them and
> finally install it at your deisred location. All this from
> running a single SHELL file. This is what I did and it worked
> like a charm.
>
> I've currently used this toolchain to compile 2.4.x kernels,
> haven't tried
> 2.6.x.
>
> Contact me if you want any more details.
>
> ~Ashwin
>

Thank you, I will take a look.

Aron

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
