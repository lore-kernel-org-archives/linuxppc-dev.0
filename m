Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2519167B73
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Apr 2005 12:50:37 +1000 (EST)
In-Reply-To: <200504142024.41126.rscop@matrix.com.br>
References: <200504140926.01775.Schramel.Linux@go.bartec.de>
	<a06218f5ec69af94cf7d5f7616eed028@embeddededge.com>
	<200504141454.03704.Schramel.Linux@go.bartec.de>
	<200504142024.41126.rscop@matrix.com.br>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ca0dbea676037b37464b3318b4271a30@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 14 Apr 2005 22:50:22 -0400
To: Ricardo Scop <rscop@matrix.com.br>
Cc: PPC_LINUX <linuxppc-embedded@ozlabs.org>
Subject: Re: CPM uart
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Apr 14, 2005, at 7:24 PM, Ricardo Scop wrote:

> I suggest you to seek all smc_scc_num references inside both the 
> console
> routines and the #ifdef SCC_CONSOLE ... #endif code snippets. They 
> should be
> subtracted by SCC_NUM_BASE whenever they're used to access SCC-related 
> stuff,

This has all been corrected in later versions of the driver.  Take a
look at the linuxppc_2.4_devel or some other BK ppc kernels.  Start
at penguinppc.org for kernel access information.

Yes, I know, it shouldn't be in this state, but it is.  Find the 
various kernel
sources and peruse for what fits your requirements.

Thanks.

	-- Dan
