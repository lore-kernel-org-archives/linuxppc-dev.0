Message-Id: <5.1.0.14.0.20010817160247.00ab96e0@spudcentral.com>
Date: Fri, 17 Aug 2001 16:07:45 -0600
To: Mark Pilon <mark.pilon@minolta-qms.com>,
	linuxppc-embedded@lists.linuxppc.org
From: "Dr. Craig Hollabaugh" <craig@hollabaugh.com>
Subject: Re: init fails w/ new build of gcc & glibc
In-Reply-To: <3B7D82D5.DD98A109@minolta-qms.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 02:47 PM 8/17/2001 -0600, Mark Pilon wrote:
>running w/ the hhl 1.2 libraries the whole system runs fine;
>
>supplying all of the libraries built under the new glibc causes the
>following when init is spawned:


Did you set the prefix to / on the glibc configure line then do a make

install_root=/somelibdirectoryforyournewrootfs

you can do this or...

in your new root filesystem something like this in your /usr/powerpc-linux/lib

ln -s ../../lib lib


the glibs have absolute path info in them, so either reconfigure and recompile for
your rootfs using prefix=/ (make sure you use install_root when you make install) or
make a link.

Hope this helps.

Craig
ps. I'm going down this very road, let's talk.



___________________________________________________________
Dr. Craig Hollabaugh                           craig@hollabaugh.com
304 6th Avenue, P.O. Box 1405
Ouray, CO 81427-1405                       See my "kitchen sink" resume at
970 325 0319 home                                  www.hollabaugh.com/resume.html
970 325 0509 office
215 882 1880 cell


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
