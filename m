Message-ID: <20000303203225.3481.qmail@web1001.mail.yahoo.com>
Date: Fri, 3 Mar 2000 12:32:25 -0800 (PST)
From: Dan Bethe <dan_bethe@yahoo.com>
Subject: Re: HFS+ feature request
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> The official format of HFS+ does specify that the strings are
> compared
> in a case insensitive way.  In fact, it goes further and specifies a
> bunch of details about actual Unicode sequences and I really don't
> want
> to break all of that.

	I understand that.  My request was basically just that we have an
option for that.  Basically, to have something like this:

# mount -t hfsplus -o rw,casesensitive /dev/sda1 /mnt/local/sda1

	And the default can be case insensitive-but-preserving, like MacOS and
the official specs state.  I just want the chance to be able to use it
as a "real" filesystem, sharing the maximum amount of space while I
still have to deal with the silliness of MacOS  :)  If I could format
/usr with HFS+, I'd give that a shot.
	If any of you have access to a MacOS 10 which installs its root with
HFS+, let's see how it behaves.  I have MacOS 10 "Server" 1.0 on my
powerbook, and its root fs is UFS BSD 4.4.

> If you can give me an image of an HFS+ filesystem with some of this
> UNIX style
> stuff, I can enable that stuff in the linux driver as well.  The
> official
> spec doesn't say much about the permissions, ownership, devices, etc.
>  It
> just says that they will be supported, and reserves a block for UNIX
> style
> info like device numbers and uid/gid.  I figured I'd ignore that
> stuff until
> I could get more info about the way OSX would handle it.

	Good idea.  Let's keep cooking on this!  It would be funny if
eventually HFS+ was the most compatible unix-based filesystem on all
Linux architectures  :)


=====
"Don't expect your own messiah; this neverworld which you desire is
only in your mind." -- http://www.dreamtheater.net/songb4.htm#IV5

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
