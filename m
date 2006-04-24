Return-Path: <pnasrat@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id BE6EF67A3E
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Apr 2006 07:09:17 +1000 (EST)
Subject: Re: [PATCH] DTC - validation by device_type
From: Paul Nasrat <pnasrat@redhat.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <5E473F0A-C2E2-4ABD-A9FA-E83C4B4CB6C3@kernel.crashing.org>
References: <1143586160.2660.19.camel@enki.eridu>
	<66cc5bfb5a367a814fbace8105572658@penguinppc.org>
	<1143599612.2704.14.camel@enki.eridu>
	<1145547307.5314.118.camel@cashmere.sps.mot.com>
	<1145905793.4082.27.camel@enki.eridu>
	<5E473F0A-C2E2-4ABD-A9FA-E83C4B4CB6C3@kernel.crashing.org>
Content-Type: text/plain
Date: Mon, 24 Apr 2006 17:09:04 -0400
Message-Id: <1145912945.4082.32.camel@enki.eridu>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-04-24 at 22:55 +0200, Segher Boessenkool wrote:

> 1) It's hard to see how any (physical) network device would
> not have a "reg" property.  It is not required though.
> 
> 2) "local-mac-address" is not a required property.
> 
> 3) "mac-address" is only required for nodes that have been
> opened before.
> 
> 4) "address-bits" is not required (taken as 48 if absent).
> 
> Please see Annex A (look at the property names, and perhaps
> at the "network" device type).  _Always_ look at Annex A!
> It's normative.

My bad.  Jon, just drop this from your queue then. 

Paul 
