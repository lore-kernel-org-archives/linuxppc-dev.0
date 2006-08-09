Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4572267BA4
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2006 01:37:38 +1000 (EST)
Subject: Re: [PATCH] update {g5,iseries,pseries}_defconfigs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <44D8A33D.6070000@sipsolutions.net>
References: <1154718328.5748.13.camel@farscape.rchland.ibm.com>
	<17624.10083.56514.758904@cargo.ozlabs.ibm.com>
	<44D84145.7020408@sipsolutions.net>
	<1155048001.5454.27.camel@farscape.rchland.ibm.com>
	<44D8A33D.6070000@sipsolutions.net>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 17:35:25 +0200
Message-Id: <1155137725.17187.46.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-08-08 at 16:44 +0200, Johannes Berg wrote:
> Will Schmidt wrote:
> > For G5, I've enabled SND_AOA and friends as
> > modules; this includes the FABRIC_LAYOUT, ONYX, TAS, TOONIE and
> > SOUNDBUS* config options.  
> >   
> Great, thanks.
> 
> Another thing I didn't think about earlier: does Apple ship any G5s that 
> are old enough to not have a layout_id in their device tree? I'm not 
> aware of any. If not, you might want to disable CONFIG_SND_POWERMAC for g5.

None.

Ben.
