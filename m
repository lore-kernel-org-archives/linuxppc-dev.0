Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E940AB6F1A
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Dec 2009 09:26:08 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nAUMPmEF012025
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Nov 2009 15:25:59 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nAUMTiCU025078
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Nov 2009 16:29:44 -0600 (CST)
Message-ID: <4B14465A.3080804@freescale.com>
Date: Mon, 30 Nov 2009 16:25:30 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 00/10 v6]  Fix 8xx MMU/TLB
References: <1258712471-3104-1-git-send-email-Joakim.Tjernlund@transmode.se>	
	<OF44DA1806.2D9916D9-ONC125767B.003BE84B-C125767B.003C3CD7@transmode.se>
	<1259357845.2076.9.camel@pasglop>
In-Reply-To: <1259357845.2076.9.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Fri, 2009-11-27 at 11:57 +0100, Joakim Tjernlund wrote:
>> Scott and Rex, I think we need you s-o-b to make it into the kernel proper.
>>
>> Marcelo and Vitaly, I noticed you guys are listed as 8xx maintainers.
>> Have you seen this? What do you think?
> 
> I think Marcelo isn't much involved with 8xx anymore. I'd say if Scott
> and Vitaly are ok, then the patches are good. But I'll wait for at least
> Scott to give an Ack as he can at least test which I can't :-)

ACK

-Scott
