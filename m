Return-Path: <benh@kernel.crashing.org>
Message-ID: <1331933034.3105.171.camel@pasglop>
Subject: Re: issues calling of_platform_bus_probe() twice
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Sat, 17 Mar 2012 08:23:54 +1100
In-Reply-To: <31B4E554-FA95-431D-B353-92680CD14A0A@kernel.crashing.org>
References: <31B4E554-FA95-431D-B353-92680CD14A0A@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "devicetree-discuss@lists.ozlabs.org
 Discuss" <devicetree-discuss@lists.ozlabs.org>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-03-16 at 16:21 -0500, Kumar Gala wrote:
> Guys,
> 
> Are you aware of any reason that we can't call of_platform_bus_probe()
> or multiple times.  Timur's run into an issue in which all devices
> don't get registered properly if we call of_platform_bus_probe() times
> with different of_device_id struct's.

Nothing comes to mind... Grant ?

Cheers,
Ben.
