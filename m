Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by ozlabs.org (Postfix) with ESMTP id A72A8DDDF2
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Dec 2007 00:38:29 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id a29so5565931pyi.0
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Dec 2007 05:38:28 -0800 (PST)
Date: Sun, 16 Dec 2007 07:38:18 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Device Tree updates for xilinx.
Message-ID: <20071216073818.4cfa7787@vader.jdub.homelinux.org>
In-Reply-To: <20071216070404.GK21311@localhost.localdomain>
References: <20071204012811.AD70CEF004D@mail134-dub.bigfish.com>
	<20071213233945.E8FFAA6007C@mail180-sin.bigfish.com>
	<20071216070404.GK21311@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Michal Simek <simekm2@fel.cvut.cz>,
	git <git@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 16 Dec 2007 18:04:04 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> > 	cpus {
> > 		#address-cells = <1>;
> > 		#cpus = <1>;
> > 		#size-cells = <0>;
> > 		PowerPC,405@0 {
> 
> I'm trying to encourage people to move to naming cpu nodes simply
> "cpu@XX", with the type of core in "compatible" instead - in keeping
> with the generic names convention used elsewhere.  I think this will
> make your generator simpler, too.

cpu@XX with the model property of the node set to "PowerPC,405" please.

josh
