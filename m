Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 46C9ADDEDC
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 02:31:00 +1000 (EST)
Message-ID: <461D0D2E.5030300@freescale.com>
Date: Wed, 11 Apr 2007 11:30:38 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 6/8] bootwrapper: convert flatdevtree to version 16
References: <boot-4-06.miltonm@bga.com>
In-Reply-To: <boot-4-06.miltonm@bga.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Milton Miller wrote:
> kexec-tools still produces a version 2 device tree, while the
> libraries in the wrapper only support version 16 and later.
> 
> Add a routine to convert a v2 flat device tree to a v16 one inplace
> by inserting OF_DT_NOP and chomping full path.  Make space for new
> headers by moving and then chomping the OF_DT_NOPs.

Why not fix kexec-tools to generate a version 17 device tree?

-Scott
