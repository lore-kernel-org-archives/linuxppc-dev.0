Return-Path: <olof@lixom.net>
Received: from elcamino.pasemi.com (elcamino.pasemi.com [67.155.108.98])
	by ozlabs.org (Postfix) with ESMTP id B69A2DDE09
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 13:03:29 +1000 (EST)
Message-Id: <02FCB4F0-AA68-479F-9BF3-15FC54714C2D@lixom.net>
From: Olof Johansson <olof@lixom.net>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <BD25BA47-04A5-4FF7-86FD-959BCDB898A0@lixom.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [RFC/PATCH 3/3] adjust cpu power for secondary threads on POWER6
Date: Wed, 18 Jun 2008 22:03:27 -0500
References: <1213835374-10868-1-git-send-email-ntl@pobox.com>
	<1213835374-10868-4-git-send-email-ntl@pobox.com>
	<BD25BA47-04A5-4FF7-86FD-959BCDB898A0@lixom.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Nathan Lynch <ntl@pobox.com>, Anton Blanchard <anton@samba.org>,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 18, 2008, at 9:58 PM, Olof Johansson wrote:

> Why not just NULL out the cpu_power function pointers on platforms  
> that don't have the feature bit instead? (or the other way around:  
> NULL by default, and set only on platforms that have imbalanced  
> threads.

Nevermind; bogus optimization. I just noticed that it's only used when  
setting up the sched domains, and isn't adding path length later on. :)


-Olof
