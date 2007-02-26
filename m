Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C021FDDE01
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Feb 2007 01:01:45 +1100 (EST)
In-Reply-To: <20070226171709.A2E8.MOKUNO@sm.sony.co.jp>
References: <20070226171709.A2E8.MOKUNO@sm.sony.co.jp>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <730e425f26d097b006a7d4419533ff5d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Remove some redunant isync instructions
Date: Mon, 26 Feb 2007 15:01:35 +0100
To: MOKUNO Masakazu <mokuno@sm.sony.co.jp>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Remove some redundant isync instructions.
>
> enable_64b_mode() already does an isync, so there is no need to do it 
> again.
>
> Signed-off-by: MOKUNO, Masakazu <mokuno@sm.sony.co.jp>

Looks good to me...


Segher
