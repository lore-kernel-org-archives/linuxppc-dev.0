Date: Mon, 10 Jan 2000 21:10:47 +0000
From: "Robin O'Leary" <robin@equiinet.com>
To: Dan Malek <dan@netx4.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linux-2.3.37 / 2.3.18 / 2.2.13
Message-ID: <20000110211045.F8416@mail.ro.nu>
References: <20000107213528.A29581@mail.ro.nu> <387A38DB.8C51AB1D@netx4.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <387A38DB.8C51AB1D@netx4.com>; from dan@netx4.com on Mon, Jan 10, 2000 at 02:54:03PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jan 10, 2000 at 02:54:03PM -0500, Dan Malek wrote:
> The 2.2.xx kernels are certainly the most stable and recommended
> if you are building products.  There is a 2.2.13 tar image on
> ppc.kernel.org/embedded for 8xx processors.  I don't know when
> some of the recent changes happened, but the generic 2.3.18
> kernel has all of the 8xx changes.

Most recently (apart from trying the doomed 2.3.37) I have been using
2.3.18 (from ftp://linuxppc.cs.nmt.edu/pub/linuxppc/embedded) on
custom 860T hardware.  As you may have gathered from my earlier post
on 1999-11-29, all has not been going smoothly.  Although I have now
coaxed 2.3.18 as far as trying to load the initrd, it has been an uphill
struggle all the way and I still haven't got the compressed bootloader
going properly.  Could it be that my problems stem from using 2.3.18?

Robin O'Leary.
-- 
email: robin@equiinet.com  Equiinet Ltd., Innovation Centre, Singleton Park,
Tel.:  +44 1792 540008     Swansea  SA2 8PP, Wales, U.K.  51.6101N 3.9831W

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
