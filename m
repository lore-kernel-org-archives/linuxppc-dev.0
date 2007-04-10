Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A0561DDEB7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Apr 2007 02:31:20 +1000 (EST)
Date: Tue, 10 Apr 2007 20:31:16 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: MPC 8349e-mITX and MTD/Flash
Message-ID: <20070410203116.66bf91e5@vitb.ru.mvista.com>
In-Reply-To: <461BB1DB.9050503@freescale.com>
References: <CF7E46FCFF66AD478BB72724345289EC2795D1@twx-exch01.twacs.local>
	<572211.38645.qm@web306.biz.mail.mud.yahoo.com>
	<CF7E46FCFF66AD478BB72724345289EC2795D2@twx-exch01.twacs.local>
	<461BB1DB.9050503@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "Benedict, Michael" <MBenedict@twacs.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 10 Apr 2007 10:48:43 -0500
Timur Tabi <timur@freescale.com> wrote:

> Having said that, it seems that the kernel now supports defining the physmap via the OF 
> tree.  Is that true?

Yes, we drafted some stuff while working on mpc8540ads - see
drivers/mtd/maps/physmap_of.c

-- 
Sincerely, 
Vitaly
