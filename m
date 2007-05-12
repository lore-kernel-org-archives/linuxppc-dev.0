Return-Path: <righiandr@users.sourceforge.net>
Received: from as3.cineca.com (as3.cineca.com [130.186.84.211])
	by ozlabs.org (Postfix) with ESMTP id 94B83DDDCA
	for <linuxppc-dev@ozlabs.org>; Sat, 12 May 2007 22:04:15 +1000 (EST)
Message-ID: <46459959.6020802@users.sourceforge.net>
From: Andrea Righi <righiandr@users.sourceforge.net>
MIME-Version: 1.0
To: Maxim Uvarov <muvarov@ru.mvista.com>
Subject: Re: [PATCH] Performance Stats: Kernel patch
References: <20070511171308.9897.93893.stgit@localhost.localdomain>
In-Reply-To: <20070511171308.9897.93893.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Date: Sat, 12 May 2007 12:39:31 +0200 (MEST)
Cc: msyrchin@ru.mvista.com, LKML <linux-kernel@vger.kernel.org>,
	wli@holomorphy.com, dada1@cosmosbay.com, linuxppc-dev@ozlabs.org,
	pavel@ucw.cz
Reply-To: righiandr@users.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Maxim Uvarov wrote:
> diff --git a/Documentation/accounting/taskstats-struct.txt b/Documentation/accounting/taskstats-struct.txt
> index 661c797..606aef6 100644
> --- a/Documentation/accounting/taskstats-struct.txt
> +++ b/Documentation/accounting/taskstats-struct.txt
> @@ -22,6 +22,8 @@ There are three different groups of fields in the struct taskstats:
>      /* Extended accounting fields end */
>      Their values are collected if CONFIG_TASK_XACCT is set.
>  
> +4) Per-task and per-thread statistics
> +
>  Future extension should add fields to the end of the taskstats struct, and
>  should not change the relative position of each field within the struct.
>  
> @@ -158,4 +160,9 @@ struct taskstats {
>  
>  	/* Extended accounting fields end */
>  
> +4) Per-task and per-thread statiscits

...a small typo in the documentation: s/statiscits/statistics/

-Andrea
