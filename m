Return-Path: <adam@semicircular.net>
Received: from mail.semicircular.net (214.20.233.220.exetel.com.au
	[220.233.20.214]) by ozlabs.org (Postfix) with ESMTP id C3A3D67A64
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Mar 2005 16:07:05 +1100 (EST)
Received: by mail.semicircular.net (Exim 3.35) id 1D74mB-0005qI-00
	for <linuxppc-embedded@ozlabs.org>; Fri, 04 Mar 2005 15:50:59 +1100
Message-ID: <4227E990.5050604@semicircular.net>
Date: Fri, 04 Mar 2005 15:52:32 +1100
From: Adam Kent <adam@semicircular.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <42162571.5060204@ru.mvista.com>
In-Reply-To: <42162571.5060204@ru.mvista.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Subject: Re: [PATCH] PCI bridge support for MPC8272 and PQ2FADS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Vitaly Bordug wrote:
> This patch adds PCI bridge support for MPC8272 and PQ2FADS to the
> current linuxppc-2.4 tree. Actually it has been tested with 8272, but
> PQ2 _should_ also work, though it will complain that host bridge ID is
> unrecognized.

This patch is against the linuxppc-2.4 tree, but it seems there is 
also no support for the MPC8272ADS / PQ2FADS PCI bridge in the 
linuxppc-2.5 kernel tree.

Before I go and "forward" port it myself, are there any other patches 
out there that add support for PCI for the 8272ADS under the 2.6 kernel?

Thanks,
Adam Kent
