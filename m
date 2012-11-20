Return-Path: <stern+50b2734e@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by ozlabs.org (Postfix) with SMTP id 1F0872C007E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2012 08:50:55 +1100 (EST)
Date: Tue, 20 Nov 2012 16:44:13 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Bill Pemberton <wfp5p@virginia.edu>
Subject: Re: [PATCH 159/493] usb: remove use of __devinit
In-Reply-To: <1353349642-3677-159-git-send-email-wfp5p@virginia.edu>
Message-ID: <Pine.LNX.4.44L0.1211201642540.1692-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: cbe-oss-dev@lists.ozlabs.org, Kukjin Kim <kgene.kim@samsung.com>,
 Wan ZongShun <mcuos.com@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Felipe Balbi <balbi@ti.com>,
 Geoff Levand <geoff@infradead.org>, linux-omap@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
 Olav Kongas <ok@artecdesign.ee>, Lennert Buytenhek <kernel@wantstofly.org>,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 19 Nov 2012, Bill Pemberton wrote:

> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.
> 
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>

For all the __devinit* annotations and all the EHCI, OHCI, and UHCI 
drivers:

Acked-by: Alan Stern <stern@rowland.harvard.edu>
