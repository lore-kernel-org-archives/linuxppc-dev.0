To: "Embedded Linux PPC list" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: list of 2.6-related migration issues for embedded programmers?
References: <Pine.LNX.4.60.0407190807450.9101@dell.enoriver.com>
From: "Linh Dang" <linhd@nortelnetworks.com>
Date: Mon, 19 Jul 2004 13:32:15 -0400
In-Reply-To: <Pine.LNX.4.60.0407190807450.9101@dell.enoriver.com> (Robert P.
 J. Day's message of "Mon, 19 Jul 2004 08:15:41 -0400")
Message-ID: <wn5k6wzgaxs.fsf@linhd-2.ca.nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 19 Jul 2004, rpjday@mindspring.com wrote:

>
>
> - replace devfs with udev:  currently, even with my current 8xx 2.6
> build, i'm sticking with devfs until i'm confident i understand
> enough to move up.

It depends on your need. For our project, we don't use neither. Our
init script read sysfs and do all the mknod-ings at boot time. it's
just 2 for-loops of 3-lines each. But ofcourse, we have no hot-plug
devices nor loadable modules.


>
> - initramfs:  currently, i'm still using a zImage.initrd-based
> image, and all i know about initramfs is that it's checked for at
> boot time.  should i care about it?  at some point, probably, i'm
> sure.

initramfs is convenient. you don't need root access nor special tools
to create the root-fs. it very easy when you want to
version-controlled you root-fs.


my $0.02

--
L.D.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
