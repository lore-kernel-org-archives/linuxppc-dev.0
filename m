Message-ID: <38968938.71C46FD5@netx4.com>
Date: Tue, 01 Feb 2000 02:20:24 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: Pavel Roskin <pavel_roskin@geocities.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Download timeout problems on Embedded Planet CLLF (was Patch for zsrec.c)
References: <20000201005642.914451B3E8@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:


> ....... but I'm having no end of
> trouble with the download timeouts


There is some trouble with large downloads and high network
traffic.  I don't know exactly the trouble, but Embedded Planet
is working to correct this.  I have discussed it with them, and
probably bypassed their normal technical support channel so the
person that answered the phone or replied to your e-mail may not
see any problem report.......

I get around this two ways.  First, split the download into
smaller pieces.  Second, modify a Linux/PPC kernel to only
use the first 4 Mbytes of memory, put it into the flash rom,
write a program to copy a file from the (NFS) file system into
mmap()'ed physical memory, and modify the kernel restart
function so a reboot with the appropriate parameters jumps to
this new code.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
