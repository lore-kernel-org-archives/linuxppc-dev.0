Return-Path: <felipe@cvf.fr>
Received: from mh2.cvf.fr (unknown [213.56.76.234])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B35F72BF17
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Jan 2005 00:59:29 +1100 (EST)
From: Philippe Guyot <pguyot@cvf.fr>
To: Sven Luther <sven.luther@wanadoo.fr>
Date: Wed, 5 Jan 2005 15:02:17 +0100
References: <33721.82.10.231.190.1104781370.squirrel@82.10.231.190>
	<200501051049.19225.pguyot@cvf.fr> <20050105114719.GB14332@pegasos>
In-Reply-To: <20050105114719.GB14332@pegasos>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200501051502.17519.pguyot@cvf.fr>
Cc: Ulrich Teichert <krypton@ulrich-teichert.org>, linuxppc-dev@ozlabs.org,
	debian-powerpc@lists.debian.org, mikemartin@linux.ca
Subject: Re: 43p-140 install issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 05 January 2005 12:47, Sven Luther wrote:
> On Wed, Jan 05, 2005 at 10:49:19AM +0100, Philippe Guyot wrote:
> > > BTW, i have another question. I am trying to fix debian-installer to
> > > create the prep partition, but i would like to have some info on the
> > > expected constraints of said partition. Some tell it has to be entirely
> > > in the first 8MB, others the first 5MB, and my powerstack has a 17MB
> > > boot partition right now.
> >
> > All I can say, it's that my boot PReP partition is the 1st and about 4 MB
> > in size (cannot size it less than 1% of the disk.....)
> > second partition is /
> > third is swap.
>
> BTW, for debian, it makes more sense to have the second partition as swap,
> and the third as /, i think, since it was decided some time back to default
> to root=/dev/sda3, and not sda2.

Yes, I did that on my two 150.

>
> > That works for me.
>
> Until the kernel grows beyond 4MB.
>

Friendly.
Felipe
