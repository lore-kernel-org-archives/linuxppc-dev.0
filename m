Return-Path: <stern+53040a98@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by ozlabs.org (Postfix) with SMTP id BCE1E2C0459
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Feb 2014 02:41:52 +1100 (EST)
Date: Fri, 21 Feb 2014 10:41:50 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Alistair Popple <alistair@popple.id.au>
Subject: Re: [PATCH 4/7] ECHI Platform: Merge ppc-of EHCI driver into the
 ehci-platform driver
In-Reply-To: <1392964293-13687-5-git-send-email-alistair@popple.id.au>
Message-ID: <Pine.LNX.4.44L0.1402211037300.1273-100000@iolanthe.rowland.org>
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

> Currently the ppc-of driver uses the compatibility string
> "usb-ehci". This means platforms that use device-tree and implement an
> EHCI compatible interface have to either use the ppc-of driver or add
> a compatible line to the ehci-platform driver. It would be more
> appropriate for the platform driver to be compatible with "usb-ehci"
> as non-powerpc platforms are also beginning to utilise device-tree.
> 
> This patch merges the device tree property parsing from ehci-ppc-of
> into the platform driver and adds a "usb-ehci" compatibility
> string. The existing ehci-ppc-of driver is removed and the 440EPX
> specific quirks are added to the ehci-platform driver.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>

This patch is also out of date.  The compatibility string used by the 
ehci-platform driver is "generic-ehci".

There remains the question of whether to merge ehci-ppc-of into
ehci-platform.  This would be a rather invasive change, but I suppose
we could do it.  With adjustments along the lines suggested by Mark
Rutland.

Alan Stern
