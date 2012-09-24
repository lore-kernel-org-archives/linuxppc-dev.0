Return-Path: <alan@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by ozlabs.org (Postfix) with ESMTP id EFEF52C0081
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2012 23:19:49 +1000 (EST)
Date: Mon, 24 Sep 2012 14:21:10 +0100
From: Alan Cox <alan@linux.intel.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] Powerpc 8xx CPM_UART setting MAXIDL register
 proportionaly to baud rate
Message-ID: <20120924142110.4a07a225@bob.linux.org.uk>
In-Reply-To: <201209240639.q8O6di6f029596@localhost.localdomain>
References: <201209240639.q8O6di6f029596@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Marcelo Tosatti <marcelo@kvack.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 24 Sep 2012 08:39:44 +0200
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> MAXIDL is the timeout after which a receive buffer is closed when not
> full if no more characters are received. We calculate it from the
> baudrate so that the duration is always the same at standard rates:
> about 4ms. At 9600 bauds it gives a timeout of 4 characters, which is
> the timeout on the 8250 UART.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Looks good tome - series Acked-by: Alan Cox <alan@linux.intel.com>
