Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 936FD67A64
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Apr 2005 17:15:32 +1000 (EST)
Date: Wed, 27 Apr 2005 00:15:27 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Wrobel Heinz-r39252 <Heinz.Wrobel@freescale.com>
Message-ID: <20050427071527.GA440@gate.ebshome.net>
References: <DF02D66C37C26B4C8018BF84F0E37FEC08440764@zwg18exm01.ea.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DF02D66C37C26B4C8018BF84F0E37FEC08440764@zwg18exm01.ea.freescale.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [RFC] [PATCH] ppc32: workaround for spurious IRQs on PQ2
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Apr 27, 2005 at 08:54:44AM +0200, Wrobel Heinz-r39252 wrote:
> Eugene,
> 
> check slides 17, 20-22 out of my SNDF 2004 presentation H1125 found at
> http://www.freescale.com/webapp/sps/site/overview.jsp?nodeId=052577pzMPYZjg286165422098
> 

Thanks a lot for the link, looks like my interpretation of events was 
correct.

As a side note, I'd be great if _User manual_ has all this 
information (and I always rant about Moto/Freescale manuals on 
#mklinux) :)

-- 
Eugene
