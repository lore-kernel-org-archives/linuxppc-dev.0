Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7BD9667A44
	for <linuxppc-dev@ozlabs.org>; Fri, 26 May 2006 00:42:21 +1000 (EST)
Date: Thu, 25 May 2006 07:41:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] PowerMac: force only suspend-to-disk to be valid
Message-Id: <20060525074145.2fe59ce6.akpm@osdl.org>
In-Reply-To: <1148566305.11759.35.camel@johannes.berg>
References: <1148566305.11759.35.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg <johannes@sipsolutions.net> wrote:
>
> This patch adds the .valid callback to pm_ops on PowerMac so that only the
>  suspend to disk state can be entered. Note that just returning 0 would
>  suffice since the upper layers don't pass PM_SUSPEND_DISK down, but we
>  handle it there regardless just in case that changes.

That's the "what" - please provide the "why":  what bug does this fix, and
what are the consequences of not having this patch?
