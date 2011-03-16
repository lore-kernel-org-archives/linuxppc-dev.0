Return-Path: <mingo@elte.hu>
Received: from fallback.mail.elte.hu (fallback.mail.elte.hu [157.181.151.13])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3E99DB6FAB
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Mar 2011 23:51:30 +1100 (EST)
Date: Wed, 16 Mar 2011 13:50:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: perf: Handle events that raise an exception
	without overflowing
Message-ID: <20110316125053.GA7387@elte.hu>
References: <20110309143842.6c22845e@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110309143842.6c22845e@kryten>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, a.p.zijlstra@chello.nl,
	acme@ghostprotocols.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Anton Blanchard <anton@samba.org> wrote:

> 
> Events on POWER7 can roll back if a speculative event doesn't
> eventually complete. Unfortunately in some rare cases they will
> raise a performance monitor exception. We need to catch this to
> ensure we reset the PMC. In all cases the PMC will be 256 or less
> cycles from overflow.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> Cc: stable@kernel.org
> ---
> 
> I would prefer not to add the PVR check, but I think we want to limit
> this workaround to POWER7. Would a cpu feature be preferable?

There was no objection from the PowerPC folks so i'll send this fix Linuswards, ok?

Thanks,

	Ingo
