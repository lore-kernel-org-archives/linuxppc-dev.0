Return-Path: <wfarnsworth@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 8D48267A6B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Mar 2005 03:09:14 +1100 (EST)
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Josh Boyer <jwboyer@jdub.homelinux.org>
In-Reply-To: <1110937421.28218.27.camel@jdub.homelinux.org>
References: <1110907039.24673.12.camel@rhino.az.mvista.com>
	<1110937421.28218.27.camel@jdub.homelinux.org>
Content-Type: text/plain
Message-Id: <1110989349.24673.99.camel@rhino.az.mvista.com>
Mime-Version: 1.0
Date: 16 Mar 2005 09:09:10 -0700
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 1/3] PPC440EP SoC and Bamboo board support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2005-03-15 at 18:43, Josh Boyer wrote:
> On Tue, 2005-03-15 at 10:17 -0700, Wade Farnsworth wrote:
> > Hello all,
> > 
> > This adds support for the IBM/AMCC PPC440EP SoC and the Bamboo reference
> > board.  Any comments would be appreciated.
> 
> Isn't the NAND chip on that board a 64MiB chip?  If so, the
> BAMBOO_NAND_FLASH_SIZE define is wrong.  It should be 0x4000000.
> 
> Also, are there any plans to add MTD support for the NAND controller
> found on those boards?
> 
> thx,
> josh

Yes, you're right.  I'll fix that.

I'm working on MTD support, including support for the NAND controller.

Thanks,
Wade Farnsworth
