Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A9F111A0631
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 17:56:57 +1100 (AEDT)
Message-ID: <551B96B8.3050708@ozlabs.org>
Date: Wed, 01 Apr 2015 14:56:56 +0800
From: Jeremy Kerr <jk@ozlabs.org>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Reword the "returning from prom_init" message
References: <1427697489-30249-1-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1427697489-30249-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Cc: pc@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

> Let's try something different.
> 
> This prints:
> 
>   Quiescing Open Firmware ...
>   Booting Linux via __start() ...

"returning from prom_init" has been an emblem of the powerpc kernel boot
since old times. I feel like we should give the old message a Viking
funeral and pick a date for a minute of silence.

(Wistfully-)Acked-by: Jeremy Kerr <jk@ozlabs.org>

Cheers,


Jeremy
