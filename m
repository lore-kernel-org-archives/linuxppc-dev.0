Date: Sun, 1 Aug 1999 16:24:52 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@mvista.com>
To: brad allison <jackal@aol.net>
cc: Multiple recipients of list <linuxppc-dev@lists.linuxppc.org>,
        linuxppc-user@lists.linuxppc.org
Subject: Re: internal zip drive support on a G3 laptop
In-Reply-To: <Pine.SGI.4.00.9908011740270.8980-100000@osiris.office.aol.com>
Message-ID: <Pine.LNX.3.96.990801162321.32341A-100000@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 1 Aug 1999, brad allison wrote:

> It doesn't appear that I can mount my internal zip drive from either bay.
> 
> I'm using gdr's 2.2.10 off of (http://gdr.free.fr/linux.html).
> 
> bash-2.03# dmesg |grep -i zip
> hdc: IOMEGA MAC ZIP 100 MAC ATAPI, ATAPI CDROM drive
> 
> bash-2.03# mount -t hfs /dev/hdc /zip
> mount: block device /dev/hdc is write-protected, mounting read-only
> mount: wrong fs type, bad option, bad superblock on /dev/hdc,
>        or too many mounted file systems
> 
> I've tried it in both the left (hde) and right (hdc) bays.
> 
> Since it's a mac formatted zip disk it should mount up as hfs file system.

Zip disks, just like hard drives, normally have partitions.  Unless you've
done something really bizarre to create a whole-disk partition, it should
be something like /dev/hdc3 or whatever.  Check with pdisk to get the
actual partition number.


David


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
