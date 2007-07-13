Return-Path: <"evil@g-house.de"@mail.g-house.de>
Received: from mail.g-house.de (ns2.g-housing.de [81.169.133.75])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2190BDDDFE
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 16:44:09 +1000 (EST)
Date: Fri, 13 Jul 2007 08:43:56 +0200 (CEST)
From: Christian Kujau <lists@nerdbynature.de>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: Weird oopses with 2.6.22-rc7
In-Reply-To: <20070712233719.GK17955@localdomain>
Message-ID: <alpine.DEB.0.99.0707130840470.18512@sheep.housecafe.de>
References: <alpine.DEB.0.99.0707130016270.18512@sheep.housecafe.de>
	<20070712233719.GK17955@localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=us-ascii
Sender: "evil@g-house.de"@mail.g-house.de
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 12 Jul 2007, Nathan Lynch wrote:
> Have you tried 2.6.22?  Linus committed a utimensat-related oops fix
> right before releasing it:

Ah, this seem to have fixed http://lkml.org/lkml/2007/7/8/21 and really 
looks promising, I'll try 2.6.22-git2 now.

thanks,
Christian.
-- 
BOFH excuse #208:

Your mail is being routed through Germany ... and they're censoring us.
