Message-ID: <383D8E81.BF75878@netx4.com>
Date: Thu, 25 Nov 1999 14:31:13 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Converting zImage to S-records for CLLF/860T
References: <19991125065849.55731F393@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:

> ......but I can't find zsrec anywhere and I'm equally unsure of
> the magic incantation to objcopy. The output from the obvious:
>     powerpc-linux-objcopy -O srec zImage zImage.srec
> is far too small to be correct.


At one time I did find the proper options to objcopy to create
the proper S-record file, but I found it easier and faster to
write a simple C program to do it.  I thought I put it on the
ppc.kernel.org server, but I will do that again.


> Could someone please point me in the right direction to find zsrec?

Look on the ppc.kernel.org server in a few minutes.  The program
just strips the 64K ELF header and converts the rest of the
file into S-Records.  You can use -h to include the header, in
case the file isn't ELF and you want the header.  You can use -s
to specify a different (hex) start address for the S-records.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
