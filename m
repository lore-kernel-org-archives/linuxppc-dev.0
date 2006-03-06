Return-Path: <pantelis@embeddedalley.com>
Received: from smtp101.biz.mail.re2.yahoo.com (smtp101.biz.mail.re2.yahoo.com
	[68.142.229.215]) by ozlabs.org (Postfix) with SMTP id 11D3167A6C
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Mar 2006 05:43:18 +1100 (EST)
From: Pantelis Antoniou <pantelis@embeddedalley.com>
To: Antonio Di Bacco <antonio.dibacco@aruba.it>
Subject: Re: Anyone back-ported fs_enet to 2.4? Possible?
Date: Mon, 6 Mar 2006 20:45:13 +0200
References: <20060306151715.11926.qmail@mx1.aruba.it>
	<200603061829.30754.pantelis@embeddedalley.com>
	<200603061928.03561.antonio.dibacco@aruba.it>
In-Reply-To: <200603061928.03561.antonio.dibacco@aruba.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200603062045.13779.pantelis@embeddedalley.com>
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

On Monday 06 March 2006 20:28, Antonio Di Bacco wrote:
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
> Thank you,
> Antonio.
> 
it is a standalone driver.
