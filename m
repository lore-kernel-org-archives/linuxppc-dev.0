Return-Path: <muvarov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 9FCAFDDEF5
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 22:51:54 +1000 (EST)
Message-ID: <46449F22.7040209@ru.mvista.com>
Date: Fri, 11 May 2007 16:51:46 +0000
From: Maxim Uvarov <muvarov@ru.mvista.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Performance Stats: Kernel patch
References: <20070508162650.704.83752.stgit@localhost.localdomain>	<20070508123214.11b4f25c.akpm@linux-foundation.org>	<4642FDD6.5090609@ru.mvista.com>
	<20070510111242.dd42adae.akpm@linux-foundation.org>
In-Reply-To: <20070510111242.dd42adae.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, wli@holomorphy.com, pavel@ucw.cz,
	dada1@cosmosbay.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Morton wrote:

>
>What I meant was: the code appears to be counting sysenter-invoked syscalls,
>but it isn't counting not int 80-invoked syscalls.
>
>  
>
You are right. Seems it should be added too.
