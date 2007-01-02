Return-Path: <dwm@enoyolf.org>
Received: from bebe.enoyolf.org (falcon30.maxeymade.com [24.173.215.190])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bebe.enoyolf.org",
	Issuer "CA Cert Signing Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 647D9DDE3A
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jan 2007 02:46:35 +1100 (EST)
In-reply-to: <20070102114212.GA4019@in.ibm.com> 
References: <20061208045537.GA14626@in.ibm.com>
	<17798.6928.378248.28903@cargo.ozlabs.ibm.com>
	<20061218105706.GB3911@in.ibm.com>
	<20070102114212.GA4019@in.ibm.com>
To: Mohan Kumar M <mohan@in.ibm.com>
Subject: Re: [Fastboot] [PATCH] Fix interrupt distribution in ppc970 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 02 Jan 2007 09:07:53 -0600
Message-ID: <31482.1167750473@bebe.enoyolf.org>
From: Doug Maxey <dwm@enoyolf.org>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	fastboot@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 02 Jan 2007 17:12:12 +0530, Mohan Kumar M wrote:
> Even after updating the JS20 box with the latest firmware FW06470160
> dated 11/21/06, we are facing the same problems with "maxcpus=1" kernel
> parameter.

The codebases for the firmware diverged between JS20 and JS21 back in '04.
So it is more than just possible there is a firmware feature in play.
