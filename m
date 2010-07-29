Return-Path: <gregkh@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B55A31007D1
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jul 2010 03:27:25 +1000 (EST)
Date: Thu, 29 Jul 2010 10:22:12 -0700
From: Greg KH <gregkh@suse.de>
To: Fushen Chen <fchen@apm.com>
Subject: Re: [PATCH 0/2 v1.04] Add support for DWC OTG driver.
Message-ID: <20100729172212.GA19363@suse.de>
References: <12803633233020-git-send-email-fchen@apm.com>
	<20100729030559.GA16667@suse.de>
	<AANLkTik35G2Th-1jN3jtx3Mn-rPNNfe3CDQgCdijHG8z@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTik35G2Th-1jN3jtx3Mn-rPNNfe3CDQgCdijHG8z@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 29, 2010 at 09:26:12AM -0700, Fushen Chen wrote:
> > [PATCH 1/2 v1.04]
> > 1. License information is under clarification.
> 
> I meant that APM is still working with Synopys to resolve the GPL License.
> There is no result yet.

Then I would be very careful in posting the code like you have done.  As
it is, the code is not something that can be legally posted or used in
any device, and you might be held liable for it :(

good luck,

greg k-h
