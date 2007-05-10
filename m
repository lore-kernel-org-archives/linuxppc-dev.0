Return-Path: <pavel@ucw.cz>
Received: from amd.ucw.cz (gprs189-60.eurotel.cz [160.218.189.60])
	by ozlabs.org (Postfix) with ESMTP id C7F66DDDEA
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 22:03:13 +1000 (EST)
Date: Thu, 10 May 2007 14:03:13 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Maxim Uvarov <muvarov@ru.mvista.com>
Subject: Re: [PATCH] Performance Stats: Kernel patch
Message-ID: <20070510120313.GD23054@elf.ucw.cz>
References: <20070510114221.7576.67522.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070510114221.7576.67522.stgit@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	wli@holomorphy.com, dada1@cosmosbay.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi!

> Patch makes available to the user the following
> task and process performance statistics:
> 	* Involuntary Context Switches (task_struct->nivcsw)
> 	* Voluntary Context Switches (task_struct->nvcsw)
> 	* Number of system calls (added new counter
> 	  thread_info->sysall_count)
> 	           
> Statistics information is available from:
>         1. taskstats interface (Documentation/accounting/)
> 	2. /proc/PID/status (task only).
> 
> This data is useful for detecting hyperactivity
> patterns between processes.

I was told nvcsw is standard name, but given how other fields are
named ("syscall_counter") I think we should use some more reasonable
name (like "voluntary_ctxt_switches" or something).
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
