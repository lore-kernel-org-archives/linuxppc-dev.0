Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 9DC6E14008E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 02:59:17 +1000 (EST)
Date: Sun, 20 Apr 2014 09:58:37 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>
Subject: Re: [RFC PATCH 0/2] usb: Reuse fsl driver code for synopsys usb
 controller
Message-ID: <20140420165837.GA5423@kroah.com>
References: <7aed4ee6-69e7-4f9f-9f45-675bc695089c@CO9EHSMHS031.ehs.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7aed4ee6-69e7-4f9f-9f45-675bc695089c@CO9EHSMHS031.ehs.local>
Cc: linux-usb@vger.kernel.org, michal.simek@xilinx.com, balbi@ti.com,
 linux-kernel@vger.kernel.org, kalluripunnaiahchoudary@gmail.com,
 kpc528@gmail.com, Punnaiah Choudary Kalluri <punnaia@xilinx.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Apr 20, 2014 at 09:57:03PM +0530, Punnaiah Choudary Kalluri wrote:
> Zynq soc contains a dual role usb controller and this IP is from synopsys. We
> observed that there is driver available for this controller from freescale and
> decided to reuse this driver for zynq use.
> 
> Here is the link for zynq soc TRM. Please refer chapter 15 for usb controller
> related information.
> http://www.xilinx.com/support/documentation/user_guides/ug585-Zynq-7000-TRM.pdf
> 
> The following series of patches add initial support for zynq soc in fsl gadget controller
> driver and fsl host controller driver.
> 
> Based on these patches, I have the following concerns and sugesstions
> 
> Since the freescale usb driver is for synopsys IP, Please consider rebranding
> this driver name and config options to reflect that it is a sysnopsys IP. So
> that other vendors who using this IP can reuse thie driver.

The config options can be edited to show the new hardware support, but
we don't usually rename kernel drivers, sorry.  That just gets messy in
the end, and the "first one here gets to name it" is usually enforced.
No users ever see a kernel driver name, especially for a gadget driver,
so it shouldn't ever really matter.

thanks,

greg k-h
