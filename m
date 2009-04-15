Return-Path: <thunderbird2k@gmail.com>
Received: from mail-bw0-f180.google.com (mail-bw0-f180.google.com
	[209.85.218.180]) by ozlabs.org (Postfix) with ESMTP id 9DB1BDDF4E
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 22:24:15 +1000 (EST)
Received: by bwz28 with SMTP id 28so2848661bwz.9
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 05:24:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200904151323.52505.jivkojj@uni-kassel.de>
References: <200904151323.52505.jivkojj@uni-kassel.de>
Date: Wed, 15 Apr 2009 14:17:47 +0200
Message-ID: <c8485d470904150517p2ed7f27dn9cfd589eb6b7a0a6@mail.gmail.com>
Subject: Re: Looking for good supported South bridge for mpc6841d
From: Roderick Colenbrander <thunderbird2k@gmail.com>
To: Zhivko Yordanov <jivkojj@uni-kassel.de>
Content-Type: text/plain; charset=KOI8-R
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 15, 2009 at 1:23 PM, Zhivko Yordanov <jivkojj@uni-kassel.de> wr=
ote:
> Hello,
>
> I'm on designing of a new embedded board, based on mpc6841d and South Bri=
dge
> ULi M1575. As =C1 reference design, I use Freescale HPCN board. However a=
fter
> consult with chip's distributor, it became clear that the M1575 is alread=
y
> discounted. Now I'm in looking of an another solution. Can somebody recom=
mend
> me an alternative, good supported from u-boot and have SATA, USB, Audio o=
n
> it? The chip must be connected with mpc6841d over PCI-Express.
>
> Best regarsds,
>
> Yordanov
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

I think the only alternatives you have are chips from Via and perhaps
Sis. It looks like Via has some nice south bridges which do what you
want, see:
http://www.via.com.tw/en/products/chipsets/south-bridges.jsp

Roderick
