Message-Id: <4.3.2.20000627073932.00b4a960@falcon.si.com>
Date: Tue, 27 Jun 2000 07:44:28 -0400
To: linuxppc-dev@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: cannot mount a floppy disc
In-Reply-To: <20000627150623.A2057@thislove.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Did you changed your software just before this started happening?  If
not, it sounds like your floppy drive is dying (dead, actually).  The
symptoms match dead hardware pretty well: I/O error (cannot read the
floppy), unkillable 100% CPU (the driver is really, really busy
retrying a write operation).  Unfortunately, a screwed up driver can
have the same symptoms.

gvb


At 03:06 PM 6/27/00 +1200, Gwyn Judd wrote:

>I have been having great difficulty lately in using floppy discs.
>Whenever I try to mount a floppy I get:
>
>[root@thislove linux]# mount /dev/fd0 /mnt/floppy/
>/dev/fd0: Input/output error
>mount: you must specify the filesystem type
>
>[root@thislove linux]# mount -t hfs /dev/fd0 /mnt/floppy/
>mount: wrong fs type, bad option, bad superblock on /dev/fd0,
>or too many mounted file systems
>
>It is definitely an hfs disc and it worked okay in macos. I know hfs
>discs work okay since I also have an hfs partition on my harddrive that
>mounts okay. If I try to format the disc using "fdformat" then I get an
>unkillable process that uses 100% of cpu.
>
>--
>Gwyn Judd (b.judd@xtra.co.nz)
>We really don't have any enemies.  It's just that some of our best
>friends are trying to kill us.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
