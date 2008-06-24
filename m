Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 49D2ADE135
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 00:07:37 +1000 (EST)
Message-Id: <2D96D638-F117-480B-A4A5-5889648D462F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <20080624105750.1118370299@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 4/9] powerpc: Make load_up_fpu and load_up_altivec callable
Date: Tue, 24 Jun 2008 09:01:29 -0500
References: <20080624105750.1118370299@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 24, 2008, at 5:57 AM, Michael Neuling wrote:

> Make load_up_fpu and load_up_altivec callable so they can be reused by
> the VSX code.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k
