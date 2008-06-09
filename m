Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CDCECDDFF3
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 09:47:11 +1000 (EST)
Subject: Re: [patch 5/5] arch/powerpc/platforms/pseries/eeh_driver.c: fix
	warning
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: akpm@linux-foundation.org
In-Reply-To: <200806092326.m59NQA9c014230@imap1.linux-foundation.org>
References: <200806092326.m59NQA9c014230@imap1.linux-foundation.org>
Content-Type: text/plain
Date: Tue, 10 Jun 2008 09:47:02 +1000
Message-Id: <1213055222.25745.16.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-06-09 at 16:26 -0700, akpm@linux-foundation.org wrote:
> From: Andrew Morton <akpm@linux-foundation.org>
> 
> Fix this:
> 
> /usr/src/devel/arch/powerpc/platforms/pseries/eeh_driver.c: In function 'print_device_node_tree':
> /usr/src/devel/arch/powerpc/platforms/pseries/eeh_driver.c:55: warning: ISO C90 forbids mixed declarations and code
> 
> also make that function look like it's part of Linux.  I mean, wtf are you
> guys up to down there??

The EEH code ... oh well. It does need some love...

> [akpm@linux-foundation.org: coding-style fixes]

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> Cc: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
