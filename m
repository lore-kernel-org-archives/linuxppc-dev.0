Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 49BBCDDECE
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 05:51:27 +1000 (EST)
Date: Mon, 30 Apr 2007 14:51:19 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Paul Mackerras <paulus@samba.org>, Kumar Gala <galak@kernel.crashing.org>
Subject: Re: patches for 2.6.22
Message-Id: <20070430145119.6713490e.kim.phillips@freescale.com>
In-Reply-To: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 27 Apr 2007 21:25:19 +1000
Paul Mackerras <paulus@samba.org> wrote:

> If anyone has patches that I haven't picked up yet which they think
> should go into 2.6.22, please send me either a pointer to the

these were missed:

[PATCH 1/4 v5] powerpc: document phy-connection-type property
Tue Apr 24 07:26:10 EST 2007
http://ozlabs.org/pipermail/linuxppc-dev/2007-April/034669.html

[PATCH 2/4 v4] powerpc: replace undocumented interface properties in dts files
Tue Apr 24 07:26:14 EST 2007
http://ozlabs.org/pipermail/linuxppc-dev/2007-April/034670.html

[PATCH 3/4] powerpc: Add 'mdio' to bus scan id list for platforms with QE UEC
Wed Apr 11 07:56:49 EST 2007
http://ozlabs.org/pipermail/linuxppc-dev/2007-April/034163.html

[PATCH 4/4] powerpc: turn on corresponding PHY drivers in QE UEC platforms defconfigs
Wed Apr 11 07:56:53 EST 2007
http://ozlabs.org/pipermail/linuxppc-dev/2007-April/034164.html

Kim
