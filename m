Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7111F684C9
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Oct 2005 05:40:35 +1000 (EST)
Date: Mon, 10 Oct 2005 21:40:29 +0200
From: Olaf Hering <olh@suse.de>
To: Simon Richter <Simon.Richter@hogyros.de>
Message-ID: <20051010194029.GA13730@suse.de>
References: <20051010163349.GA1381@suse.de> <434A9B87.409@hogyros.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <434A9B87.409@hogyros.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: error: implicit declaration of function 'cpu_die'
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Mon, Oct 10, Simon Richter wrote:

> Hi,
> 
> >arch/ppc/kernel/idle.c includes linux/smp.h, which includes asm-smp.h
> >only if CONFIG_SMP is defined.
> >As a result, cpu_die remains undefined for non-SMP builds.
> 
> I have used the attached patch for my tree[1], but this needs to be 
> cross-checked with the other architectures.

Looks good, should go into 2.6.14.



-- 
short story of a lazy sysadmin:
 alias appserv=wotan
