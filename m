Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D4524DDEE9
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 22:44:52 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4ACikWr008209
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 08:44:46 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4ACik7N172704
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 06:44:46 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4ACijPg008519
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 06:44:46 -0600
Subject: Re: [PATCH] Performance Stats: Kernel patch
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Maxim Uvarov <muvarov@ru.mvista.com>
In-Reply-To: <20070510123950.7984.24745.stgit@localhost.localdomain>
References: <20070510123950.7984.24745.stgit@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 10 May 2007 07:38:42 -0500
Message-Id: <1178800722.22802.12.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	wli@holomorphy.com, pavel@ucw.cz, dada1@cosmosbay.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-05-10 at 12:39 +0000, Maxim Uvarov wrote:
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

This should be sent to the linux-kernel list I think...  Or at least
CCd.

josh
