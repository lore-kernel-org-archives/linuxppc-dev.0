Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 17A8867F1E
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 Aug 2005 08:55:56 +1000 (EST)
Date: Fri, 5 Aug 2005 15:54:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matt Porter <mporter@kernel.crashing.org>
Message-Id: <20050805155442.4e3dbf8f.akpm@osdl.org>
In-Reply-To: <20050805154505.A10842@cox.net>
References: <20050805154505.A10842@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc32: fix ppc440 pagetable attributes
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Matt Porter <mporter@kernel.crashing.org> wrote:
>
> This patch fixes a bug in the PPC440 pagetable attributes that breaks  
>  swap support.  It also adds some notes on the PPC440 attribute fields.

hm, that looks pretty serious, but it affects all ppc's, yes?

Is this needed for 2.6.13?   Are you super-sure it's safe?
