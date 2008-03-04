Return-Path: <SRS0+1e9828ccf53712a7f548+1654+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 302B1DE060
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 03:37:40 +1100 (EST)
Subject: Re: V4L2: __ucmpdi2 undefined on ppc
From: David Woodhouse <dwmw2@infradead.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <15d7ac5a7542b05fb9b9abb5d4c7a22d@kernel.crashing.org>
References: <Pine.SOC.4.61.0612131359430.10721@math.ut.ee>
	<1166053317.909.19.camel@praia>
	<20061214195842.GA14041@athena.road.mcmartin.ca>
	<1166362145.6714.53.camel@pmac.infradead.org>
	<6a89f9d50802060639j4b3a8b7u4e4e596b010ee353@mail.gmail.com>
	<15d7ac5a7542b05fb9b9abb5d4c7a22d@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 04 Mar 2008 16:37:28 +0000
Message-Id: <1204648648.3891.439.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: paulus@samba.org, henrik.sorensen@gmail.com,
	Stephane Marchesin <marchesin@icps.u-strasbg.fr>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun, 2008-03-02 at 22:53 +0100, Segher Boessenkool wrote:
> Every occurrence of r7 here is wrong (and some of the r6).

Can you elucidate?

>   Is there any reason to do this in assembler code at all?

Is there any particular reason not to?

-- 
dwmw2
