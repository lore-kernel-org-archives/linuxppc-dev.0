Return-Path: <tglx@linutronix.de>
Received: from linutronix.de (www.linutronix.de [62.245.132.108])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C37E5B6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 31 Mar 2011 00:32:20 +1100 (EST)
Date: Wed, 30 Mar 2011 15:32:13 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH] powerpc: rename get_irq_desc_data and
 get_irq_desc_chip
In-Reply-To: <20110330132504.GA31832@riccoc20.at.omicron.at>
Message-ID: <alpine.LFD.2.00.1103301531200.22418@localhost6.localdomain6>
References: <20110330132504.GA31832@riccoc20.at.omicron.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Lennert Buytenhek <buytenh@secretlab.ca>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 30 Mar 2011, Richard Cochran wrote:

> These two functions disappeared in commit
> 
>     0c6f8a8b917ad361319c8ace3e9f28e69bfdb4c1
>     "genirq: Remove compat code"
> 
> but they still exist in qe_ic.h.
> This patch renames the function to their new names.

oops. I really need to figure out to teach coccinelle not to ignore
header files.
 
