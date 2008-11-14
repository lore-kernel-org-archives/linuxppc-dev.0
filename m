Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id C2E33DDDDB
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2008 16:31:02 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so553999ywh.39
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 21:31:00 -0800 (PST)
Message-ID: <fa686aa40811132130h4c87c91fp47e1763c4a751b2a@mail.gmail.com>
Date: Thu, 13 Nov 2008 22:30:59 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Yuri Tikhonov" <yur@emcraft.com>
Subject: Re: Re[2]: [PATCH] katmai.dts: extend DMA ranges; add dma/sysace nodes
In-Reply-To: <919499964.20081114082725@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200811131149.14715.yur@emcraft.com>
	<20081113064533.77eccc1b@zod.rchland.ibm.com>
	<20081114050001.GA15181@secretlab.ca>
	<919499964.20081114082725@emcraft.com>
Cc: linuxppc-dev@ozlabs.org, Wolfgang Denk <wd@denx.de>,
	Detlev Zundel <dzu@denx.de>, Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 13, 2008 at 10:27 PM, Yuri Tikhonov <yur@emcraft.com> wrote:
>
> Hello Grant,
>
> On Friday, November 14, 2008 you wrote:
>
>> On Thu, Nov 13, 2008 at 06:45:33AM -0500, Josh Boyer wrote:
>>> On Thu, 13 Nov 2008 11:49:14 +0300
>>> Yuri Tikhonov <yur@emcraft.com> wrote:
>>> > +           sysacecf@4fe000000 {
>>> > +                   compatible = "xlnx,opb-sysace-1.00.b";
>>>
>>> Odd.  This isn't a xilinx board by any means.  This should probably
>>> look something like:
>>>
>>>       compatible = "amcc,sysace-440spe", "xlnx,opb-sysace-1.00.b";
>
>> Actually, if there is a sysace, it is definitely a xilinx part.  It
>> won't be on the SoC.  However, compatible = "xlnx,opb-sysace-1.00.b"
>> isn't really accurate.  It should really be compatible = "xlnx,sysace"
>> and the driver modified to accept this string.
>
>  OK, we'll do this, and then re-post together with the cleaned-up
> "[PATCH] xsysace: use resource_size_t instead of unsigned long" patch.

Please cc: me on the next version of the xsysace patch.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
