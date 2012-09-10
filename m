Return-Path: <alan@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by ozlabs.org (Postfix) with ESMTP id CC8EF2C0086
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 22:52:31 +1000 (EST)
Date: Mon, 10 Sep 2012 14:10:21 +0100
From: Alan Cox <alan@linux.intel.com>
To: leroy christophe <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] Powerpc 8xx CPM_UART delay in receive
Message-ID: <20120910141021.6e7762d6@bob.linux.org.uk>
In-Reply-To: <504D922C.1030407@c-s.fr>
References: <201208141426.q7EEQSPc003956@localhost.localdomain>
 <20120814155227.018988da@pyramind.ukuu.org.uk>
 <502CF2A0.8080109@c-s.fr>
 <20120816152918.5ed2649f@pyramind.ukuu.org.uk>
 <502D054B.3010606@c-s.fr>
 <20120816162136.059b64b4@bob.linux.org.uk>
 <504D922C.1030407@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> * a value of 1 for all rates below 2400 (On 8250, fifo is set to 1
> for such rates)
> * a value of 2 for 2400 and 4800
> * a value of 4 for 9600 (which is the default on the 8250 for all
> rates above 2400)
> * a value of 8 for 19200
> * a value of 16 for 38400 and above (on UCC_UART, maxidl is set to
> 16, never 32)

That would seem sensible.



Alan
