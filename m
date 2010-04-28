Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6B280B7D55
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 14:18:26 +1000 (EST)
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc: add platform registration
	for ALSA SoC drivers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <s2ifa686aa41004271215tb3c992c1v8996ce5520896c6c@mail.gmail.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<4BD6FA39.3030400@freescale.com> <1272381611.11000.39.camel@odin>
	<4BD70292.20001@freescale.com> <1272386470.11000.84.camel@odin>
	<4BD72DB0.20808@freescale.com>
	<s2ifa686aa41004271215tb3c992c1v8996ce5520896c6c@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 28 Apr 2010 14:18:15 +1000
Message-ID: <1272428295.24542.65.camel@pasglop>
Mime-Version: 1.0
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com,
	broonie@opensource.wolfsonmicro.com, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-04-27 at 13:15 -0600, Grant Likely wrote:
> 
> Can you not dynamically assign an id?  If alsa soc needs a unique id
> number, then just create a lookup function.  Something like
> of_asoc_phandle_to_codec_id() that will either return a previously
> assigned id, or will assign a new id.  You shouldn't ever need to add
> data to the tree at runtime. 

Numerical magic IDs are evil... why not a name ? Or it's existing alsa
breakage ? :-)

Cheers,
Ben.
