Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B0487B6FD3
 for <linuxppc-dev@ozlabs.org>; Sun, 10 Jun 2012 08:36:09 +1000 (EST)
Message-ID: <1339281364.24838.94.camel@pasglop>
Subject: Re: [PATCH 01/15] i2c/powermac: Register i2c devices from device-tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Date: Sun, 10 Jun 2012 08:36:04 +1000
In-Reply-To: <m2k3zgf79j.fsf@igel.home>
References: <1334823416-9138-1-git-send-email-benh@kernel.crashing.org>
 <1334823416-9138-2-git-send-email-benh__33169.052625499$1334826821$gmane$org@kernel.crashing.org>
 <m2r4tofuxr.fsf@igel.home> <1339279889.24838.93.camel@pasglop>
 <m2k3zgf79j.fsf@igel.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2012-06-10 at 00:30 +0200, Andreas Schwab wrote:
> > Should we keep the tas_create method for those ? We could have some code
> > in the aoa core file that calls those "fixups" to create missing
> > devices...
> 
> I'm not sure if the function is needed, if the device can be created in
> i2c_powermac_register_devices.

But it doesn't have a device-node ... does it ? Which machine is this
btw ? Can you shoot me privately the device-tree ? That will help me
figure out what exactly needs to be done.

Thanks !

Cheers,
Ben.
