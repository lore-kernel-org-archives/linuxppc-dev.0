Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 2A17EDDF6D
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 00:22:07 +1100 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0ba5eb018563b895658033d2db0c9b9f@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] ppc64: Enable RELOCATABLE option for CRASH_DUMP
Date: Mon, 5 Jan 2009 07:28:54 -0600
To: M. Mohan Kumar <mohan@in.ibm.com>
Cc: linux-ppc <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mohan wrote:

>  config CRASH_DUMP
>         bool "Build a kdump crash kernel"
> -       depends on (PPC64 && RELOCATABLE) || 6xx
> +       depends on PPC64 || 6xx
> +       select RELOCATABLE
>         help
>           Build a kernel suitable for use as a kdump capture kernel.
>           The same kernel binary can be used as production kernel and 
> dump
>

You should only select relocatable if ppc64

milton
