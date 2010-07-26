Return-Path: <gregkh@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 2B157B70C6
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jul 2010 09:17:49 +1000 (EST)
Date: Mon, 26 Jul 2010 16:16:16 -0700
From: Greg KH <gregkh@suse.de>
To: Feng Kan <fkan@apm.com>
Subject: Re: [PATCH 1/2 v1.03] Add support for DWC OTG HCD function.
Message-ID: <20100726231616.GA25342@suse.de>
References: <12801701823001-git-send-email-fchen@apm.com>
	<20100726213704.GA16268@suse.de>
	<4C4E0449.2070108@caviumnetworks.com>
	<20100726220513.GA9671@suse.de> <20100726220809.GA9784@suse.de>
	<AANLkTinbTnrr9DCiSgKngAjaak=U0qDYcCxbNZR4Nm3D@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTinbTnrr9DCiSgKngAjaak=U0qDYcCxbNZR4Nm3D@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org,
	Mark Miesfeld <mmiesfeld@apm.com>, David Daney <ddaney@caviumnetworks.com>,
	Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 26, 2010 at 04:05:49PM -0700, Feng Kan wrote:
> Hi Greg:
> 
> We are having our legal revisit this again. What would you advise us
> to do at this point?

I thought I was very clear below as to what is needed.

> Disclose the agreement or have someone with legal authority reply this
> thread.

Neither will resolve the end issue, right?

> Perhaps something in the header that states Applied Micro verified
> with Synopsys to use this code for GPL purpose.

No, that will just make it messier.  Someone needs to delete all of the
mess in the file, put the proper license information for what the code
is being licensed under (whatever it is), and provide a signed-off-by
from a person from Synopsys and APM that can speak for the company that
they agree that the code can properly be placed into the Linux kernel.

thanks,

greg k-h
