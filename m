Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DD3C2B7D19
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Apr 2010 15:15:50 +1000 (EST)
Subject: Re: [RFC] powerpc: add support for new hcall H_BEST_ENERGY
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: svaidy@linux.vnet.ibm.com
In-Reply-To: <20100407045718.GA14391@dirshya.in.ibm.com>
References: <20100303181822.GH5439@dirshya.in.ibm.com>
	<1270605889.13812.117.camel@pasglop>
	<20100407045718.GA14391@dirshya.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 07 Apr 2010 15:13:38 +1000
Message-ID: <1270617218.2300.1.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-04-07 at 10:27 +0530, Vaidyanathan Srinivasan wrote:

> > Check the result. Also that's not a nice way to do that, you should look
> > for /cpus by path I reckon.
> 
> I will check the return code, but why do you feel getting the node by
> path is better?  Is there any race, or we may have duplicate "cpus"
> node?

Well, you never really know what might be down the device-tree :-) /cpus
is well defined where it is, while god knows what would happen if
somebody had the weird idea to have something called "cpus" below some
device driver for whatever reason they might even.

Cheers,
Ben.
