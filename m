Return-Path: <glikely@secretlab.ca>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.231])
	by ozlabs.org (Postfix) with ESMTP id D82E3DEB67
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 01:39:17 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 67so315969wri.3
	for <linuxppc-dev@ozlabs.org>; Thu, 05 Jun 2008 08:39:16 -0700 (PDT)
Message-ID: <fa686aa40806050839h55d8e358m93248414507f10e2@mail.gmail.com>
Date: Thu, 5 Jun 2008 09:39:15 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
In-Reply-To: <4848028B.5060105@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200806041706.21557.sr@denx.de> <4846B39F.3010601@freescale.com>
	<20080604154351.GB10393@ld0162-tx32.am.freescale.net>
	<20080604211942.2bddc860@zod.rchland.ibm.com>
	<4848028B.5060105@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 5, 2008 at 9:13 AM, Timur Tabi <timur@freescale.com> wrote:
> Josh Boyer wrote:
>
>> From a device tree perspective, index and cell-index are both
>> incorrect.  The IIC macros don't share register blocks with anything,
>> are enumerated as unique instances per macro in the device tree, and
>> should be able to be distinguished by "regs" and/or unit address.
>
> I think we should just expand the definition of cell-index to include standard
> device enumeration for when it's needed.  The original definition is too
> limited, IMHO.

nak

if you need explicit indexing then use an alias.  My opinion however
is that explicit indexing is unnecessary and is just an artifact of
current i2c subsystem internals.  There is already enough information
in the device tree to match i2c devices with i2c busses without
resorting to indexes.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
