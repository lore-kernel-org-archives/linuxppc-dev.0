Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 74E59679A6
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Jul 2006 00:34:51 +1000 (EST)
In-Reply-To: <20060701102557.GA14013@lst.de>
References: <9FCDBA58F226D911B202000BDBAD467306E04FF6@zch01exm40.ap.freescale.net>
	<1151709194.27137.2.camel@localhost.localdomain>
	<DCEAAC0833DD314AB0B58112AD99B93B07B36E@ismail.innsys.innovsys.com>
	<a0bc9bf80606302335p7ba227afwf69dc42e2eada64b@mail.gmail.com>
	<1151738466.27137.24.camel@localhost.localdomain>
	<20060701102557.GA14013@lst.de>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C4F75531-D046-42EF-AAF7-D45B84DA1720@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc:Fix rheap alignment problem
Date: Sat, 1 Jul 2006 09:34:45 -0500
To: Christoph Hellwig <hch@lst.de>
Cc: Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	"linux-kernel@vger.kernel.org mailing list" <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 1, 2006, at 5:25 AM, Christoph Hellwig wrote:

> On Sat, Jul 01, 2006 at 05:21:06PM +1000, Benjamin Herrenschmidt  
> wrote:
>> On Sat, 2006-07-01 at 14:35 +0800, Linux powerpc wrote:
>>> Yes, it was used for allocating dual port RAM for CPM.  And now  
>>> we are
>>> adding QE support to powerpc arch which need to use rheap(QE is next
>>> generation for CPM).  Please see the patches I <leoli@freescale.com>
>>> just posted for 8360epb support.  Moreover, previous CPM support is
>>> adding to powerpc arch too.
>>
>> Ok, well, I don't have anything specifically against that code, I was
>> just wondering if it may not duplicate something we already have (yet
>> another space allocator basically)...
>
> Yepp.  Without looking at the rheap allocator in deatail, any reason
> it can't use lib/genalloc.c?

Doing a quick glance at lib/genalloc.c I dont see any reason we  
couldn't use it.  However, Panto will know best, since he wrote rheap.

- k
