Return-Path: <sebastien.dugue@bull.net>
Received: from ecfrec.frec.bull.fr (ecfrec.frec.bull.fr [129.183.4.8])
	by ozlabs.org (Postfix) with ESMTP id 9B69CDDF07
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 20:11:48 +1000 (EST)
Date: Thu, 31 Jul 2008 12:12:18 +0200
From: Sebastien Dugue <sebastien.dugue@bull.net>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 0/3] powerpc - Make the irq reverse mapping tree lockless
Message-ID: <20080731121218.5a07596a@bull.net>
In-Reply-To: <1217497241-10685-1-git-send-email-sebastien.dugue@bull.net>
References: <1217497241-10685-1-git-send-email-sebastien.dugue@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: tinytim@us.ibm.com, linux-rt-users@vger.kernel.org,
	jean-pierre.dion@bull.net, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, paulus@samba.org,
	gilles.carry@ext.bull.net, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


  OK, I goofed up with git-format-patch, forgot the --numbered option.

  The patches subjects should read:

	[PATCH 1/3] powerpc - Initialize the irq radix tree earlier
	[PATCH 2/3] powerpc - Separate the irq radix tree insertion and lookup
	[PATCH 3/3] powerpc - Make the irq reverse mapping radix tree lockless

  Sorry for that.

  Sebastien.
