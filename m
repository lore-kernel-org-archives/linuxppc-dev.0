Date: Fri, 24 Nov 2000 11:07:47 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Adrian Cox <apc@agelectronics.co.uk>
cc: debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: apmd and other archs
In-Reply-To: <3A1D2893.6F8987FE@agelectronics.co.uk>
Message-ID: <Pine.HPX.4.10.10011241056380.14737-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 23 Nov 2000, Adrian Cox wrote:

>
> Gabriel Paubert wrote:
> > Because mount stats /etc/mtab and does not touch it if it finds that it is
> > a symlink. But this has still problem, I just can't remember which ones. I
> > know that I thought it would be great and had to go back to the standard
> > /etc/mtab.
>
> See http://www.xss.co.at/sysinfo/mounts.html

Thanks for the pointer. Now that I see it, I remember that the major
problem I had on the diskless machines was that /proc/mounts did not have
enough information, especially for the root mount point when it is an NFS
mount. The root mount point always appears as /dev/root BTW.

	Thanks,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
