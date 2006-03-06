Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4E96767B22
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Mar 2006 05:37:02 +1100 (EST)
Date: Mon, 6 Mar 2006 21:36:58 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Antonio Di Bacco <antonio.dibacco@aruba.it>
Subject: Re: Anyone back-ported fs_enet to 2.4? Possible?
Message-ID: <20060306213658.09ec5e6d@vitb.ru.mvista.com>
In-Reply-To: <200603061928.03561.antonio.dibacco@aruba.it>
References: <20060306151715.11926.qmail@mx1.aruba.it>
	<200603061829.30754.pantelis@embeddedalley.com>
	<200603061928.03561.antonio.dibacco@aruba.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 6 Mar 2006 19:28:03 +0100
Antonio Di Bacco <antonio.dibacco@aruba.it> wrote:

> On Monday 06 March 2006 17:29, Pantelis Antoniou wrote:
> > On Monday 06 March 2006 17:17, antonio.dibacco wrote:
> > > Hi,
> > >
> > > anyone back ported fs_enet to 2.4? Is it feasible in your high opinion?
> > >
> > > Bye,
> > > Antonio.
> >
> > The original patches of fec_8xx did.
> >
> > Try to get a hold of them.
> >
> > Pantelis
> 
> 
> Hi,
> 
> I saw a fec_8xx folder under drivers/net/, is this driver used by fs_enet or 
> is it a standalone driver for the FECs?
> 

fs_enet is the replacement of the fec_8xx... Well iirc early versions of fs_enet were functional and support 2.4 - search them around the list
At least, those patches could make you a clue what needs to be done to keep 2.4 compatibility...

> Thank you,
> Antonio.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 


-- 
Sincerely, 
Vitaly
