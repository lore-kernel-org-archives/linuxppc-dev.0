Message-ID: <396C8748.D473221E@embeddededge.com>
Date: Wed, 12 Jul 2000 10:57:12 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: "TWG - pat, mark & steve" <twg@world.std.com>
CC: Kwansuk Kim <kskim@neowave.co.kr>,
        LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: kernel can't library file
References: <Pine.SGI.3.95.1000712103124.7904A-100000@world.std.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"TWG - pat, mark & steve" wrote:
>
> In the MontaVista target directory, libdl.so.2 is a link to the actual
> library, libdl-2.1.2.so.  Make sure that the libraries are real ones, not
> just links.  (I'm a linux newbie, but I have seen that you often can't
> follow links under NFS, perhaps a protection issue?)

Any properly working NFS on a system that supports symbolic links
works fine.  You obviously can't link outside of your parent tree,
but this doesn't do that.  These distributions won't work if symbolic
links don't.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
