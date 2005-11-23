Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C303F687C7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 01:05:23 +1100 (EST)
Date: Wed, 23 Nov 2005 06:34:55 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Message-ID: <20051123083455.GA3308@logos.cnet>
References: <437DFEFA.4080203@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <437DFEFA.4080203@ru.mvista.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32: 8xx board-specific platform stuff for fs_enet
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Vitaly,

On Fri, Nov 18, 2005 at 07:19:06PM +0300, Vitaly Bordug wrote:
> This adds board-specific files needed to utilize fs_enet Ethernet driver
> for MPC885ADS and MPC866ADS.
> 
> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>

Looks nice.

Just one thing: Would mind separating the setbits/clearbits patch, and
while you're at it, convert the current read-and-modify operations to
setbits/clearbits?

They have been switched to use IO accessors with GIT commit
e37b0c9670fed2264661ade1beb5c228dec29c96

Thanks
