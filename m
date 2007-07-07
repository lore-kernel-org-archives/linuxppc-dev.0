Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A9948DE06E
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 Jul 2007 15:24:16 +1000 (EST)
Message-ID: <468F239B.5070800@freescale.com>
Date: Sat, 07 Jul 2007 00:24:43 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Clifford Wolf <clifford@clifford.at>
Subject: Re: Mem-2-Mem DMA - Generalized API
References: <20070624193932.GA11797@clifford.at>	<200706242221.57507.arnd@arndb.de>	<467FA0EA.3000607@genesi-usa.com>
	<467FBABD.9040103@anagramm.de>	<467FD1DF.4000602@genesi-usa.com>	<20070625180110.GH20463@clifford.at>
	<20070704090554.GA30693@clifford.at>
In-Reply-To: <20070704090554.GA30693@clifford.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Clifford Wolf wrote:
> Hi,
> 
> On Mon, Jun 25, 2007 at 08:01:10PM +0200, Clifford Wolf wrote:
>> I've put a 'draft header file' of an api as I would have expected it
>> online: [...]
> 
> Ok, so here comes the first implementation:
> (I also have other projects, so it took a while.. ;-)
> 
> 	http://www.clifford.at/priv/dmatransfer-20070704.diff

Why aren't you following the DMA API in include/linux/dmaengine.h?
