Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0814BDDE05
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 May 2007 01:02:53 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: zImage.elf loads but does not start
Date: Wed, 9 May 2007 08:02:50 -0700
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A207@MERCURY.inside.istor.com>
In-Reply-To: <4640F08E.5040608@nec.com.au>
From: "Charles Krinke" <ckrinke@istor.com>
To: "Adrian Craine" <adrian.craine@nec.com.au>,
	"Leonid" <Leonid@a-k-a.net>
Cc: Mirek23 <miroslaw.dach@psi.ch>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I find this usually happens when /dev/tty, /dev/console or /dev/ttyS0
are not setup properly. That is, they are files instead of nodes. This
menas you have mounted the root filesystem and init is running on that
root filesystem.

Charles


-----Original Message-----
From: linuxppc-embedded-bounces+ckrinke=3Distor.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+ckrinke=3Distor.com@ozlabs.org] On
Behalf Of Adrian Craine
Sent: Tuesday, May 08, 2007 2:50 PM
To: Leonid
Cc: linuxppc-embedded@ozlabs.org; Mirek23
Subject: Re: zImage.elf loads but does not start

Leonid wrote:
> rootpath=3D
> [    9.130834] Looking up port of RPC 100003/2 on 129.129.130.106
> [    9.207363] Looking up port of RPC 100005/1 on 129.129.130.106
> [    9.303794] VFS: Mounted root (nfs filesystem).
> [    9.359316] Freeing unused kernel memory: 96k init
> [    9.422162] Warning: unable to open an initial console.
>
>  =20
The exact device node this requires is /dev/console c 5 1
That should solve your issue.

Cheers,
             Adrian.
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
