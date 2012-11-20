Return-Path: <tklauser@sym2.noone.org>
Received: from sym2.noone.org (sym2.noone.org [178.63.92.236])
 by ozlabs.org (Postfix) with ESMTP id 9B8A72C007D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 20:55:48 +1100 (EST)
Date: Tue, 20 Nov 2012 10:45:33 +0100
From: Tobias Klauser <tklauser@distanz.ch>
To: Bill Pemberton <wfp5p@virginia.edu>
Subject: Re: [PATCH 429/493] tty: remove use of __devexit
Message-ID: <20121120094533.GH25445@distanz.ch>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-429-git-send-email-wfp5p@virginia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1353349642-3677-429-git-send-email-wfp5p@virginia.edu>
Cc: nios2-dev@sopc.et.ntust.edu.tw, Jiri Slaby <jirislaby@gmail.com>,
 gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
 uclinux-dist-devel@blackfin.uclinux.org, Tony Prisk <linux@prisktech.co.nz>,
 Bryan Huntsman <bryanh@codeaurora.org>, linux-serial@vger.kernel.org,
 Lucas Tavares <lucaskt@linux.vnet.ibm.com>, sparclinux@vger.kernel.org,
 Daniel Walker <dwalker@fifo99.com>, David Brown <davidb@codeaurora.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2012-11-19 at 19:26:18 +0100, Bill Pemberton <wfp5p@virginia.edu> wrote:
> CONFIG_HOTPLUG is going away as an option so __devexit is no
> longer needed.
> 
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Jiri Slaby <jirislaby@gmail.com> 
> Cc: Alan Cox <alan@linux.intel.com> 
> Cc: Tobias Klauser <tklauser@distanz.ch> 
> Cc: Lucas Tavares <lucaskt@linux.vnet.ibm.com> 
> Cc: David Brown <davidb@codeaurora.org> 
> Cc: Daniel Walker <dwalker@fifo99.com> 
> Cc: Bryan Huntsman <bryanh@codeaurora.org> 
> Cc: "David S. Miller" <davem@davemloft.net> 
> Cc: Peter Korsgaard <jacmet@sunsite.dk> 
> Cc: Tony Prisk <linux@prisktech.co.nz> 
> Cc: linuxppc-dev@lists.ozlabs.org 
> Cc: linux-serial@vger.kernel.org 
> Cc: nios2-dev@sopc.et.ntust.edu.tw 
> Cc: uclinux-dist-devel@blackfin.uclinux.org 
> Cc: linux-arm-msm@vger.kernel.org 
> Cc: sparclinux@vger.kernel.org 
> Cc: linux-arm-kernel@lists.infradead.org 
> ---
[...]
>  drivers/tty/serial/altera_jtaguart.c        |  2 +-
>  drivers/tty/serial/altera_uart.c            |  2 +-

Acked-by: Tobias Klauser <tklauser@distanz.ch>
