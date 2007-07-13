Return-Path: <"evil@g-house.de"@mail.g-house.de>
Received: from mail.g-house.de (ns2.g-housing.de [81.169.133.75])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 40A70DDDFE
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jul 2007 06:23:38 +1000 (EST)
Date: Fri, 13 Jul 2007 22:23:20 +0200 (CEST)
From: Christian Kujau <lists@nerdbynature.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Weird oopses with 2.6.22-rc7 [SOLVED]
In-Reply-To: <alpine.DEB.0.99.0707130840470.18512@sheep.housecafe.de>
Message-ID: <alpine.DEB.0.99.0707132221320.18512@sheep.housecafe.de>
References: <alpine.DEB.0.99.0707130016270.18512@sheep.housecafe.de>
	<20070712233719.GK17955@localdomain>
	<alpine.DEB.0.99.0707130840470.18512@sheep.housecafe.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=us-ascii
Sender: "evil@g-house.de"@mail.g-house.de
Cc: Nathan Lynch <ntl@pobox.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 13 Jul 2007, Christian Kujau wrote:
> Ah, this seem to have fixed http://lkml.org/lkml/2007/7/8/21 and really
> looks promising, I'll try 2.6.22-git2 now.

for the record: running 2.6.22-git3 now and the Oopses went away ;)

thanks,
Christian.
-- 
BOFH excuse #352:

The cables are not the same length.
