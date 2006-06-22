Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9DFC8679FF
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 22:09:57 +1000 (EST)
Subject: Re: [PATCH] Don't access HID registers if running on a Hypervisor.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jimi Xenidis <jimix@watson.ibm.com>
In-Reply-To: <6BBF4F7C-1375-41FF-8D42-43BEC67194CC@watson.ibm.com>
References: <E1FtBvP-00026H-TC@kmac.watson.ibm.com>
	<20060621235156.GA5414@pb15.lixom.net>
	<6BBF4F7C-1375-41FF-8D42-43BEC67194CC@watson.ibm.com>
Content-Type: text/plain
Date: Thu, 22 Jun 2006 22:09:43 +1000
Message-Id: <1150978183.3633.49.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-06-22 at 06:58 -0400, Jimi Xenidis wrote:

> 970s consider this a no-op (I believe an expensive one) especially  
> when you consider some of the synchronization issues around the mtspr  
> HIDx.
> And though this is 970 specific code, Cell and future processors,  
> will no longer allow writing to to these registers if !(MSR[0]=1 &&  
> MSR[PR]=0)

Fair enough, let's fix it.

Ben.
