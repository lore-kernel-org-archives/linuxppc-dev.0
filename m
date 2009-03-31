Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E7CA8DDE41
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 00:32:11 +1100 (EST)
Message-Id: <6B1588B3-522D-4C7B-AFA9-5CE361CCA95F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20090331120550.GA2332@yoda.jdub.homelinux.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc: Make LOWMEM_CAM_NUM depend on FSL_BOOKE
Date: Tue, 31 Mar 2009 08:32:04 -0500
References: <20090331120550.GA2332@yoda.jdub.homelinux.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 31, 2009, at 7:05 AM, Josh Boyer wrote:

> The recent addition of CONFIG_LOWMEM_CAM_BOOL and
> CONFIG_LOWMEM_CAM_NUM cause the latter to show up in configs
> that do not need it during 'make oldconfig'.  Make LOWMEM_CAM_NUM
> depend on FSL_BOOKE.
>
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
>
> ---

fixed up an applied

- k
