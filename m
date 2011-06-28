Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B867DB6F5C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jun 2011 23:45:57 +1000 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p5SDbJ2u028588
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2011 07:37:19 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p5SDja0g124898
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2011 07:45:37 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p5S7jZRU028951
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2011 01:45:35 -0600
Date: Tue, 28 Jun 2011 09:45:37 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: jdl@jdl.com, david@gibson.dropbear.id.au
Subject: Re: [PATCH] dtc: Remove unused variable in flat_read_mem_reserve
Message-ID: <20110628134537.GE10237@zod.rchland.ibm.com>
References: <20110628134253.GD10237@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110628134253.GD10237@zod.rchland.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 28, 2011 at 09:42:53AM -0400, Josh Boyer wrote:
>The *p variable is declared and used to save inb->ptr, however p is
>later never used.  This has been the case since commit 6c0f3676 and can
>lead to build failures with -Werror=unused-but-set-variable:
>
>	flattree.c: In function 'flat_read_mem_reserve':
>	flattree.c:700:14: error: variable 'p' set but not used [-Werror=unused-but-set-variable]
>	cc1: all warnings being treated as errors
>	make: *** [flattree.o] Error 1
>
>Remove the variable.

Whoops.  I had a dirty git tree on this that had the other change in it
still.  I'll resend.

josh
