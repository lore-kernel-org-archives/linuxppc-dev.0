Date: Tue, 6 Mar 2001 09:49:51 +1100
From: Graham Stoney <greyham@research.canon.com.au>
To: kingseft@samsung.co.kr
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Question about making ramdisk for ppc
Message-ID: <20010306094951.B3565@brixi.research.canon.com.au>
References: <H00002af04a72993@MHS>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <H00002af04a72993@MHS>; from kingseft@samsung.co.kr on Mon, Mar 05, 2001 at 07:20:47PM +0900
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Mar 05, 2001 at 07:20:47PM +0900, kingseft@samsung.co.kr wrote:
>  Our linux host system's CPU is Intel and I'd like to make a ramdisk for ppc
>  of course, I think the directories of linux host system are not suitable
> for ppc ramdisk..

There are numerous options here.  Of course you need to cross-compile all
the libraries and binaries, and you need to pick a filesystem that is endian
independent, (like ext2, unlike minix for example).  For more info on actually
building the ramdisk image, see the section in the HOWTO at:
http://penguinppc.org/usr/embedded/howto/PowerPC-Embedded-HOWTO-13.html#ss13.2

Regards,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
