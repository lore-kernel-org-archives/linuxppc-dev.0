Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3EE39DDF7D
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 06:52:04 +1000 (EST)
Message-ID: <48767636.3090906@freescale.com>
Date: Thu, 10 Jul 2008 15:51:02 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] mpc7448: add alias list to DTS, clean out old chosen node
References: <1215721295-17555-1-git-send-email-paul.gortmaker@windriver.com>
	<48766E4D.5060607@freescale.com> <48767696.6090603@windriver.com>
In-Reply-To: <48767696.6090603@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Gortmaker wrote:
> OK, so does that mean that the cuboot wrapper is explicitly
> not supported for all the 83xx, 85xx, and 86xx boards?

No (except 86xx, which doesn't have cuboot, because it never existed in 
arch/ppc and thus there's no compatibility to maintain), it just means 
that chosen was never added to those dts files, and thus cuboot has no 
console output.

-Scott
