Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8A30FDDF0D
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 07:06:31 +1000 (EST)
Message-ID: <487679B1.3040900@freescale.com>
Date: Thu, 10 Jul 2008 16:05:53 -0500
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] mpc7448: add alias list to DTS, clean out old chosen node
References: <1215721295-17555-1-git-send-email-paul.gortmaker@windriver.com>	<48766E4D.5060607@freescale.com>
	<48767696.6090603@windriver.com> <48767636.3090906@freescale.com>
In-Reply-To: <48767636.3090906@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Paul Gortmaker wrote:
>> OK, so does that mean that the cuboot wrapper is explicitly
>> not supported for all the 83xx, 85xx, and 86xx boards?
> 
> No (except 86xx, which doesn't have cuboot, because it never existed in 
> arch/ppc and thus there's no compatibility to maintain), it just means 
> that chosen was never added to those dts files, and thus cuboot has no 
> console output.

Also note that nothing stops the causal kernel booter
from _starting_ with an arch/powerpc/boot/dts/ file,
adding a node to it, and using _that_.

jdl
