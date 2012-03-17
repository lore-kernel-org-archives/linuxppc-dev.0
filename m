Return-Path: <benh@kernel.crashing.org>
Message-ID: <1332026973.3105.191.camel@pasglop>
Subject: Re: issues calling of_platform_bus_probe() twice
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tabi Timur-B04825 <B04825@freescale.com>
Date: Sun, 18 Mar 2012 10:29:33 +1100
In-Reply-To: <4F649304.9010001@freescale.com>
References: <31B4E554-FA95-431D-B353-92680CD14A0A@kernel.crashing.org>
 <1331933034.3105.171.camel@pasglop> <20120317072717.738953E08CE@localhost>
 <4F649304.9010001@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "devicetree-discuss@lists.ozlabs.org
 Discuss" <devicetree-discuss@lists.ozlabs.org>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2012-03-17 at 13:35 +0000, Tabi Timur-B04825 wrote:
> >>> >  >  Are you aware of any reason that we can't call
> of_platform_bus_probe()
> >>> >  >  or multiple times.  Timur's run into an issue in which all
> devices
> >>> >  >  don't get registered properly if we call
> of_platform_bus_probe() times
> >>> >  >  with different of_device_id struct's.
> >> >
> >> >  Nothing comes to mind... Grant ?
> > Neither for me.  Should work.
> 
> I posted a work-around patch here:
> 
> http://patchwork.ozlabs.org/patch/128533/
> 
> Without this patch, drivers cannot probe on DMA *channels*, or any
> other 
> grandchildren of the root node. 

Why don't you track down the actual bug instead ?

Cheers,
Ben.
