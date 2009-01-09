Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3A8D5DDFD5
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jan 2009 11:18:49 +1100 (EST)
Message-Id: <A7C50A8F-D936-4835-99B2-ACE9D21EEF18@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1231425233-6392-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc/e500mc: Minor tweaks to init/exception code for
	e500mc
Date: Thu, 8 Jan 2009 18:18:42 -0600
References: <1231425233-6392-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 8, 2009, at 8:33 AM, Kumar Gala wrote:

> * PID1/PID2 don't exist on e500mc so we should write them
> * Doorbell exceptions need to be taken w/EE still disabled since we  
> use
>  them for things like IPIs
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/kernel/head_fsl_booke.S |    6 +++---
> 1 files changed, 3 insertions(+), 3 deletions(-)

superseded by larger cleanup.

- k
