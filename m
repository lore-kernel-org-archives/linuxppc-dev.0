Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 02FEAB6F18
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jul 2011 21:57:28 +1000 (EST)
Message-ID: <4E1ED97A.2060906@windriver.com>
Date: Thu, 14 Jul 2011 19:56:42 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: <benh@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
Subject: Re: [v3] booke/kprobe: Fix stack corrupt issue when kprobe 'stwu'
References: <1310383915-30543-1-git-send-email-tiejun.chen@windriver.com>
	<1310383915-30543-2-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1310383915-30543-2-git-send-email-tiejun.chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Tiejun Chen <tiejun.chen@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tiejun Chen wrote:
> v1 -> v2: when allocate pgirq_ctx, use 'hw_cpu' to identify cpu ID in exc_lvl_early_init().
> v2 -> v3: add that specific return-from-program-exc to restore necessary thread info then
> we can withdraw the original patch #2.

Any feedback?

Thanks
Tiejun

> 
> Tiejun
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
