Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 254DFDE2E7
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 23:48:26 +1000 (EST)
Message-Id: <AFB2881B-A365-4767-A4BF-A84BD0421A06@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <48f64aeaef7c61529488ddfadabdf67ec61a09f1.1214271072.git.michael@ellerman.id.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 06/14] powerpc: Add tests of the code patching routines
Date: Tue, 24 Jun 2008 08:48:17 -0500
References: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
	<48f64aeaef7c61529488ddfadabdf67ec61a09f1.1214271072.git.michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 23, 2008, at 8:32 PM, Michael Ellerman wrote:

> Add tests of the existing code patching routines, as well as the new
> routines added in the last commit. The self-tests are run late in boot
> when CONFIG_CODE_PATCHING_SELFTEST=y, which depends on DEBUG_KERNEL=y.
>
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k
>
