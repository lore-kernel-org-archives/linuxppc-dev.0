Message-ID: <39785AE7.FEE791D2@student.ethz.ch>
Date: Fri, 21 Jul 2000 16:15:03 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
CC: Josh Huber <huber@mclx.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: problems about __cli()
References: <200007201345.OAA29151@hyperion.valhalla.net>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe schrieb:
>
> Thu, Jul 20, 2000,  Josh Huber wrote:
> > On Thu, Jul 20, 2000 at 10:19:54AM +0100, Iain Sandoe wrote:
> >>
> > [snip]
> >>
> >> It is *vital* to make sure that there is a symlink named 'linux' in
> >> /usr/src that points to your /usr/src/your-kernel-foo-bar/ because there
> >> are symlinks in /usr/include that expect to use this to find the
> >> build-specific headers.
> >
> > A couple notes:
> >
> > You don't have to put your kernel in /usr/src, and you DON'T have to
> > symlink /usr/src/linux to it before you build.  The symlinks (on
> > broken RedHat derivatives) in /usr/include should point to the kernel
> > headers that your libc was built againt, otherwise you risk breaking
> > binary compatibility.
>
> I guess I *must* have one of those broken derivatives... and it doesn't work
> for me without that step...  Admittedly, this is mostly an issue between
> 2.2.xx and 2.4.0 - but I do have to remember to change it back between
> whiles... a better way would be ?

Have you tried 'make mrproper' (backup your .config ;), put back the old
config, then 'make oldconfig dep vmlinux'? AFAIK the directory where the tree
resides only matters after make dep, and the connection is untied with make
mrproper.


Michel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
