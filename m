Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (67-41-71-119.roch.qwest.net [67.41.71.119])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7F80967A80
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Mar 2005 12:43:43 +1100 (EST)
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Wade Farnsworth <wfarnsworth@mvista.com>
In-Reply-To: <1110907039.24673.12.camel@rhino.az.mvista.com>
References: <1110907039.24673.12.camel@rhino.az.mvista.com>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 19:43:40 -0600
Message-Id: <1110937421.28218.27.camel@jdub.homelinux.org>
Mime-Version: 1.0
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

On Tue, 2005-03-15 at 10:17 -0700, Wade Farnsworth wrote:
> Hello all,
> 
> This adds support for the IBM/AMCC PPC440EP SoC and the Bamboo reference
> board.  Any comments would be appreciated.

Isn't the NAND chip on that board a 64MiB chip?  If so, the
BAMBOO_NAND_FLASH_SIZE define is wrong.  It should be 0x4000000.

Also, are there any plans to add MTD support for the NAND controller
found on those boards?

thx,
josh
