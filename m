Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 90919DE122
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 12:48:36 +1100 (EST)
Date: Tue, 30 Oct 2007 20:56:51 -0500
From: Olof Johansson <olof@lixom.net>
To: Valentine Barshak <vbarshak@ru.mvista.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/4] PowerPC: 440GRx Rainier DTS.
Message-ID: <20071031015651.GB19318@lixom.net>
References: <20071030164511.GA21973@ru.mvista.com>
	<20071030165650.GA22107@ru.mvista.com>
	<20071030230805.GC2784@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071030230805.GC2784@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 31, 2007 at 10:08:05AM +1100, David Gibson wrote:
> On Tue, Oct 30, 2007 at 07:56:50PM +0300, Valentine Barshak wrote:
> > PowerPC 440GRx Rainier DTS.
> [snip]
> > +		SDRAM0: sdram {
> > +			device_type = "memory-controller";
> 
> How many times do we need to say it...
> 
> Don't make up random device_type values.  This does not belong here.

Maybe there should be something like checkpatch.pl that warns about
these kinds of things so people can check for it without getting flamed
first. :-)

Lots of people base their dts'es on other ones, so until the kernel has
bene clean a while, this will happen all the time. I'm saying "a while"
because people tend to base them on what's fresh when they do the work,
but it might take a few months between then and when they post, etc.


-Olof
