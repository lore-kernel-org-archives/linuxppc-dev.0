Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 64035DDED2
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Apr 2007 05:02:11 +1000 (EST)
In-Reply-To: <Pine.LNX.4.64.0704050843440.27254@osiris.atheme.org>
References: <20070318201110.181165B80F1@ganymede.vroon.org>
	<Pine.LNX.4.64.0704050843440.27254@osiris.atheme.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f0a6272033d78e0af266c8daeb0823da@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2.6.22] [resend] Allow PMU LED control on PowerMac 7,
	2 and 7, 3
Date: Thu, 5 Apr 2007 21:01:20 +0200
To: William Pitcock <nenolod@atheme.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> This patch also works on PowerMac3,5. It is also confirmed to work on 
> the
> iMac "Flower Power" model, but I do not have the specific model ID for
> that on me at the moment.

PowerMac4,1 (all of the latest iMac G3s have this ID, not
just the "Flower Power").


Segher
