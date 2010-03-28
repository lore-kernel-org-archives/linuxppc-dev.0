Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D59B5B7CBD
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Mar 2010 08:09:10 +1100 (EST)
Subject: Re: question about drivers/macintosh/windfarm_pm91.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Julia Lawall <julia@diku.dk>
In-Reply-To: <Pine.LNX.4.64.1003281746570.29824@ask.diku.dk>
References: <Pine.LNX.4.64.1003281746570.29824@ask.diku.dk>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 29 Mar 2010 08:08:59 +1100
Message-ID: <1269810539.8599.330.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2010-03-28 at 17:48 +0200, Julia Lawall wrote:
> The function wf_smu_remove in the file drivers/macintosh/windfarm_pm91.c 
> ends with the following code:
> 
>         if (wf_smu_slots_fans)
>                 kfree(wf_smu_cpu_fans);
> 	if (wf_smu_drive_fans)
>                 kfree(wf_smu_cpu_fans);
>         if (wf_smu_cpu_fans)
>                 kfree(wf_smu_cpu_fans);
> 
> This looks quite strange.  Is it supposed to be if (x) kfree(x); in each 
> case?

Definitely a typo. In fact, the if () aren't even necessary. Patch
welcome :-)

Cheers,
Ben.
