Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 919D1679FF
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Jul 2006 17:21:30 +1000 (EST)
Subject: Re: [PATCH] powerpc:Fix rheap alignment problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux powerpc <linuxppcleo@gmail.com>
In-Reply-To: <a0bc9bf80606302335p7ba227afwf69dc42e2eada64b@mail.gmail.com>
References: <9FCDBA58F226D911B202000BDBAD467306E04FF6@zch01exm40.ap.freescale.net>
	<1151709194.27137.2.camel@localhost.localdomain>
	<DCEAAC0833DD314AB0B58112AD99B93B07B36E@ismail.innsys.innovsys.com>
	<a0bc9bf80606302335p7ba227afwf69dc42e2eada64b@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 01 Jul 2006 17:21:06 +1000
Message-Id: <1151738466.27137.24.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-07-01 at 14:35 +0800, Linux powerpc wrote:
> Yes, it was used for allocating dual port RAM for CPM.  And now we are
> adding QE support to powerpc arch which need to use rheap(QE is next
> generation for CPM).  Please see the patches I <leoli@freescale.com>
> just posted for 8360epb support.  Moreover, previous CPM support is
> adding to powerpc arch too. 

Ok, well, I don't have anything specifically against that code, I was
just wondering if it may not duplicate something we already have (yet
another space allocator basically)... 

Ben.
