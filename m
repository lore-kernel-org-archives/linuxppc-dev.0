Date: Sun, 20 Aug 2000 06:15:53 -0700
From: Matt Porter <mmporter@home.com>
To: Michael Lundkvist <ml@epact.se>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems with linuxppc_2_2 on an MVME-2400
Message-ID: <20000820061553.V23680@cx258813-a.chnd1.az.home.com>
References: <qpog2ory9h.fsf@erbium.epact.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <qpog2ory9h.fsf@erbium.epact.se>; from ml@epact.se on Sun, Aug 20, 2000 at 01:02:34PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Aug 20, 2000 at 01:02:34PM +0200, Michael Lundkvist wrote:
>
> I rsync:ed against FSMLabs repository yesterday and got linuxppc_2_2
> to play with on my MVME-2400.
>
> I've got a MVME-2400 VME-board with a Ramix PMC-disk (based an a
> CMD-646 controller with an IBM disk).
>
> I can get it to boot but as soon as I start any moderate disk activity
> I get a panic in find_buffer().

<snip>

> I have a pre-compiled Debian kernel that works, but I can't seem to
> find the source for exactly that version.
>
> This is what the working version claims to be:
> Linux version 2.2.16pre4 (drow@crack.them.org) (gcc version 2.95.2 20000313 (Debian GNU/Linux)) #1 Tue Jun 6 17:34:50 CDT 2000
>
> Does anyone have any hints on how to solve this?

The source used for that build can be retrieved from the Debian powerpc
patch package at
ftp://ftp.debian.org/pub/debian/dists/stable/main/binary-powerpc/devel/kernel-patch-2.2.15-powerpc_20000422-2.2.16pre4-1.deb

Note that it comes from a 22/04/2000 FSMLabs 2.2 tree.  Use BK to "checkout
for edit" files no later than 22/04/2000 in your rsynced version and you
might find that things work.  Source control _is_ useful. :)

Oh, and one more possibility is that the unified IDE patch helped matters
since I believe Dan J. ended up applying that to the Debian image builds.
The exact patch used was ftp://ftp.debian.org/pub/debian/dists/stable/main/binary-powerpc/devel/kernel-patch-2.2.15-ide_20000405-1.deb

Regards,
--
Matt Porter
mmporter@home.com
After working on x86 one must scrub thoroughly using a wire brush.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
