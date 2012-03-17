Return-Path: <B04825@freescale.com>
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: issues calling of_platform_bus_probe() twice
Date: Sat, 17 Mar 2012 13:35:02 +0000
Message-ID: <4F649304.9010001@freescale.com>
References: <31B4E554-FA95-431D-B353-92680CD14A0A@kernel.crashing.org>
 <1331933034.3105.171.camel@pasglop> <20120317072717.738953E08CE@localhost>
In-Reply-To: <20120317072717.738953E08CE@localhost>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
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

Grant Likely wrote:
>>> >  >  Are you aware of any reason that we can't call of_platform_bus_pr=
obe()
>>> >  >  or multiple times.  Timur's run into an issue in which all device=
s
>>> >  >  don't get registered properly if we call of_platform_bus_probe() =
times
>>> >  >  with different of_device_id struct's.
>> >
>> >  Nothing comes to mind... Grant ?
> Neither for me.  Should work.

I posted a work-around patch here:

http://patchwork.ozlabs.org/patch/128533/

Without this patch, drivers cannot probe on DMA *channels*, or any other=20
grandchildren of the root node.

--=20
Timur Tabi
Linux kernel developer at Freescale=
