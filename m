Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id CC0C5DDFAD
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 15:50:26 +1000 (EST)
Date: Thu, 11 Oct 2007 00:55:43 -0500
From: Olof Johansson <olof@lixom.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 3/7] [POWERPC] remove iSeries_vio_dev
Message-ID: <20071011055543.GA1395@lixom.net>
References: <20071011144824.a5e3de59.sfr@canb.auug.org.au>
	<20071011145055.1de13742.sfr@canb.auug.org.au>
	<20071011145332.e3638c2e.sfr@canb.auug.org.au>
	<20071011052535.GA578@lixom.net> <20071011052731.GB578@lixom.net>
	<20071011152949.4a78ec1b.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071011152949.4a78ec1b.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org,
	Jens Axboe <jens.axboe@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 11, 2007 at 03:29:49PM +1000, Stephen Rothwell wrote:
> Hi Olof,
> 
> On Thu, 11 Oct 2007 00:27:31 -0500 Olof Johansson <olof@lixom.net> wrote:
> >
> > Oh nevermind, I just noticed the variable got moved in the next
> > patch. Twice the review work!
> 
> Thanks for the review in any case.

No problem. It's hard to split up changes like that anyway, I don't
blame you.

Rest of the patches look good to me. I had another couple of comments
but they were fixed by the end of the series too. :-)


-Olof
