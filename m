Return-Path: <jacmet@gmail.com>
Received: from mail-wg0-f45.google.com (mail-wg0-f45.google.com [74.125.82.45])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E397A2C072A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2012 01:02:13 +1100 (EST)
Received: by mail-wg0-f45.google.com with SMTP id dq11so2117322wgb.14
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 06:02:07 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 119/493] usb: remove use of __devexit_p
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-119-git-send-email-wfp5p@virginia.edu>
 <50AB4D90.4080907@atmel.com>
Date: Tue, 20 Nov 2012 15:02:04 +0100
In-Reply-To: <50AB4D90.4080907@atmel.com> (Nicolas Ferre's message of "Tue, 20
 Nov 2012 10:29:52 +0100")
Message-ID: <87r4nojrtv.fsf@dell.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kukjin Kim <kgene.kim@samsung.com>, Wan ZongShun <mcuos.com@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 Felipe Balbi <balbi@ti.com>, linux-samsung-soc@vger.kernel.org,
 Bill Pemberton <wfp5p@virginia.edu>, Alan Stern <stern@rowland.harvard.edu>,
 Ben Dooks <ben-linux@fluff.org>, linux-omap@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>>> "Nicolas" == Nicolas Ferre <nicolas.ferre@atmel.com> writes:

 Nicolas> On 11/19/2012 07:21 PM, Bill Pemberton :
 >> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
 >> needed.
 >> 
 >> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
 >> Cc: Peter Korsgaard <jacmet@sunsite.dk> 
 >> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com> 
 >> Cc: Felipe Balbi <balbi@ti.com> 
 >> Cc: Li Yang <leoli@freescale.com> 
 >> Cc: Alan Stern <stern@rowland.harvard.edu> 
 >> Cc: Wan ZongShun <mcuos.com@gmail.com> 
 >> Cc: Ben Dooks <ben-linux@fluff.org> 
 >> Cc: Kukjin Kim <kgene.kim@samsung.com> 
 >> Cc: linux-usb@vger.kernel.org 
 >> Cc: linux-omap@vger.kernel.org 
 >> Cc: linuxppc-dev@lists.ozlabs.org 
 >> Cc: linux-arm-kernel@lists.infradead.org 
 >> Cc: linux-samsung-soc@vger.kernel.org 

 Nicolas> [..]

 >> drivers/usb/host/ehci-atmel.c        | 2 +-

 >> drivers/usb/host/ohci-at91.c         | 2 +-

 Nicolas> For Atmel:

 Nicolas> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

For c67x00 and g_hid:

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
