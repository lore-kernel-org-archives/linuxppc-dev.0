Return-Path: <gregkh@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 377761007D1
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jul 2010 10:50:19 +1000 (EST)
Date: Thu, 29 Jul 2010 17:50:45 -0700
From: Greg KH <gregkh@suse.de>
To: Feng Kan <fkan@apm.com>
Subject: Re: [PATCH 1/2 v1.03] Add support for DWC OTG HCD function.
Message-ID: <20100730005045.GB22683@suse.de>
References: <12801701823001-git-send-email-fchen@apm.com>
	<20100726213704.GA16268@suse.de>
	<4C4E0449.2070108@caviumnetworks.com>
	<20100726220513.GA9671@suse.de> <20100726220809.GA9784@suse.de>
	<AANLkTinbTnrr9DCiSgKngAjaak=U0qDYcCxbNZR4Nm3D@mail.gmail.com>
	<20100726231616.GA25342@suse.de>
	<AANLkTikDpxcOj=TgD5697HOzPOanECGd4G6QaXZmoS98@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTikDpxcOj=TgD5697HOzPOanECGd4G6QaXZmoS98@mail.gmail.com>
Cc: linux-usb@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>,
	linuxppc-dev@ozlabs.org, Mark Miesfeld <mmiesfeld@apm.com>,
	Ted Chan <tchan@apm.com>, Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 29, 2010 at 05:14:59PM -0700, Feng Kan wrote:
> Hi Greg:
> 
> We will change to a BSD 3 clause license header. Our legal counsel is
> talking to Synopsis to make this change.

Why BSD?  You do realize what that means when combined within the body
of the kernel, right?

Are you going to be expecting others to contribute back to the code
under this license, or will you accept the fact that future
contributions from the community will cause the license to change?

> We will resubmit once this is in place. Please let me know if you have
> any additional concerns.

My main concern is that you, and everyone else involved in the driver,
never considered the license of the code in the first place and expected
the kernel community to accept it as-is, placing the problem on us.

What will be done in the future to prevent this from happening again?

thanks,

greg k-h
