Message-Id: <20000915120016.Postino-005391@smtp01.highway.ne.jp>
Date: Fri, 15 Sep 2000 12:00:16 +0900
To: Takashi Oe <toe@unlserve.unl.edu>
CC: linuxppc-dev@lists.linuxppc.org
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: ld bug?
In-Reply-To: <Pine.A41.3.96LJ1.1b7.1000914205905.93706A-100000@unlserve.unl.edu>
References: <Pine.LNX.4.10.10009132130250.452-100000@cassiopeia.home>
 <Pine.A41.3.96LJ1.1b7.1000914205905.93706A-100000@unlserve.unl.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: Takashi Oe <toe@unlserve.unl.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: ld bug?
Date: Thu, 14 Sep 2000 21:28:46 -0500 (CDT)

>
> Hi,

> as opposed to c03ac3e0 used in vmlinux.  So, it appears that ld or
> something is acting up.  I've tried various version of binutils from
> 2.9.1.0.990418 to 2.10.0.18, but all have produced the same output.
> Except for 2.9.1.0.990414, all 2.10.x versions that I tried are from
> ftp://devel.linuxppc.org/users/fsirl/R5/RPMS/.
>
> gcc is 2.95.3-2c (also from fsirl directory).
>
> If I change some totally (and seemingly) unrelated files a bit, vmlinux
> produced may be correct.  I tried to look at if any section's size
> matters, but I don't see any pattern unfortunately.
>

Lastest binutls is  2.10.0.24.

It's there.

ftp://ftp.valinux.com/pub/support/hjl/binutils/

Kaoru

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
