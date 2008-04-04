Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ADD6CDE461
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Apr 2008 09:11:07 +1100 (EST)
Subject: RE: [PATCH 1/5] [v2][POWERPC] refactor dcr code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
In-Reply-To: <20080404220239.DAAC2C6006B@mail222-sin.bigfish.com>
References: <1206401313-1625-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<20080328162616.61AEF15006B@mail199-sin.bigfish.com>
	<1206914576.10388.132.camel@pasglop>
	<20080404220239.DAAC2C6006B@mail222-sin.bigfish.com>
Content-Type: text/plain
Date: Sat, 05 Apr 2008 09:10:33 +1100
Message-Id: <1207347033.10388.434.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-04-04 at 15:02 -0700, Stephen Neuendorffer wrote:
> Ben,
> 
> Any thoughts about device tree bindings for indirect DCR?

No, not really. For 44x PCI-E, I've just used something like an
"sdr-base" property to provide the base SDR for the port, simple but not
necessarily the nicest way to do so.

Ben.
