Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (71-36-223-245.roch.qwest.net
	[71.36.223.245])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 91853683B6
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Sep 2005 10:08:55 +1000 (EST)
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Roland Dreier <rolandd@cisco.com>
In-Reply-To: <523bnrsak3.fsf@cisco.com>
References: <523bnrsak3.fsf@cisco.com>
Content-Type: text/plain
Date: Mon, 26 Sep 2005 18:36:12 -0500
Message-Id: <1127777773.25579.7.camel@yoda.jdub.homelinux.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Change #if CONFIG_6xx -> #if defined(CONFIG_6xx) in
	perfmon.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-09-26 at 15:56 -0700, Roland Dreier wrote:
> This trivial change fixes the warning
> 
>     arch/ppc/kernel/perfmon.c:48:7: warning: "CONFIG_6xx" is not defined
> 
> Signed-off-by: Roland Dreier <rolandd@cisco.com>

Ben H. already sent out this patch.  See the thread called "ppc: fix
stupid thinko in oprofile fix" :).

josh
