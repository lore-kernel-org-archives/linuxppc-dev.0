Return-Path: <cbouatmailru@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.189])
	by ozlabs.org (Postfix) with ESMTP id 5AFCBDE10B
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 07:23:01 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id e27so33796nfd.9
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 14:22:59 -0700 (PDT)
Date: Wed, 30 Apr 2008 01:22:56 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 2/6] [POWERPC] QE: add support for QE USB clocks routing
Message-ID: <20080429212256.GA3748@zarina>
References: <20080429185920.GA19735@polina.dev.rtsoft.ru>
	<20080429190031.GB21203@polina.dev.rtsoft.ru>
	<48177DAE.7030807@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <48177DAE.7030807@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 29, 2008 at 02:57:34PM -0500, Timur Tabi wrote:
> Anton Vorontsov wrote:
> > This patch adds a function to the qe_lib to setup QE USB clocks routing.
> > To setup clocks safely, cmxgcr register needs locking, so I just reused
> > ucc_lock since it was used only to protect cmxgcr.
> > 
> > The idea behind placing clocks routing functions into the qe_lib is that
> > later we'll hopefully switch to the generic Linux Clock API, thus, for
> > example, FHCI driver may be used for QE and CPM chips without nasty #ifdefs.
> > 
> > This patch also fixes QE_USB_RESTART_TX command definition in the qe.h.
> > 
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> 
> Acked-By: Timur Tabi <timur@freescale.com>

Much thanks for the review and Acks.

> Anton, please be sure to CC: me on any QE library patches you send out.

Sorry about that. I actually know that QE changes should be Cc: you,
but I always forget this. :-/ I should automate Ccing, someday.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
