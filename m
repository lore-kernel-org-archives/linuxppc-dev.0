Subject: Re: VFAT not endian safe?
To: mrz5149@acm.org (Michael R. Zucca)
Date: Mon, 1 Oct 2001 20:59:26 -0700 (PDT)
Cc: linuxppc-dev@lists.linuxppc.org (linuxppc-dev)
In-Reply-To: <l03130300b7dec9c3a691@[192.168.1.2]> from "Michael R. Zucca" at Oct 01, 2001 09:40:48 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20011002035926.7C4692B54A@marcus.pants.nu>
From: flar@pants.nu (Brad Boyer)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael R. Zucca wrote:
> A closer look at the VFAT code seems to indicate that unicode names are
> handled in the native endian order by mistake instead of being converted to
> little endian. Looking around the other FS code, I wonder if this is a
> pan-filesystem issue.
>
> I'm using at benh 2.4 from about a month ago. Does anybody know if there is
> work underway to fix this problem or should I go ahead and start plugging
> away at it?

There was a patch for this problem floating around a while ago. I suspect
that if you get a new source tree, it would work. The problem was originally
reported on the linux-fsdevel list quite a while ago.

(And I have a module for hfsplus compiling, but I don't have it running yet.)
http://www.sourceforge.net/projects/linux-hfsplus/

	Brad Boyer
	flar@allandria.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
