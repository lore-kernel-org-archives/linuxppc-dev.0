Return-Path: <stern+53040a98@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by ozlabs.org (Postfix) with SMTP id E4BA92C0323
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Feb 2014 02:41:10 +1100 (EST)
Date: Fri, 21 Feb 2014 10:34:28 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Alistair Popple <alistair@popple.id.au>
Subject: Re: [PATCH 3/7] IBM Akebono: Add support to the OHCI platform driver
 for PPC476GTR
In-Reply-To: <1392964293-13687-4-git-send-email-alistair@popple.id.au>
Message-ID: <Pine.LNX.4.44L0.1402211032080.1273-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 21 Feb 2014, Alistair Popple wrote:

> The IBM Akebono board uses the PPC476GTR SoC which has a OHCI
> compliant USB host interface. This patch adds support for it to the
> OHCI platform driver.
> 
> As we use device tree to pass platform specific data instead of
> platform data we remove the check for platform data and instead
> provide reasonable defaults if no platform data is present. This is
> similar to what is currently done in ehci-platform.c.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

As Arnd pointed out, this patch is out of date.  See

https://git.kernel.org/cgit/linux/kernel/git/gregkh/usb.git/commit/drivers/usb/host/ohci-platform.c?h=usb-next&id=ca52a17ba975dbf47e87c9bc63086aca0cf92806

and

https://git.kernel.org/cgit/linux/kernel/git/gregkh/usb.git/commit/drivers/usb/host/ohci-platform.c?h=usb-next&id=ce149c30b9f89d0c9addd1d71ccdb57c1051553b

Alan Stern
