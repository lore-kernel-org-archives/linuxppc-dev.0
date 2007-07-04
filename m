Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 6FE84DDE06
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Jul 2007 20:11:36 +1000 (EST)
Message-ID: <468B7250.3070704@anagramm.de>
Date: Wed, 04 Jul 2007 12:11:28 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
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

Clifford Wolf schrieb:
> On Mon, Jun 25, 2007 at 08:01:10PM +0200, Clifford Wolf wrote:
>> I've put a 'draft header file' of an api as I would have expected it
>> online: [...]
> 
> Ok, so here comes the first implementation:
> (I also have other projects, so it took a while.. ;-)
> 
> 	http://www.clifford.at/priv/dmatransfer-20070704.diff
> 
> This is just for the MPC8349 DMA now, registers are still hardcoded in the
> driver instead of beeing taken from the platform files and support for
> scatter-gather is still missing and the Kconfig integration isn't checking
> if we are building for the mpc8349 (or even ppc) yet. But I think the
> direction of the API is pretty clear.

That looks good. It should be useful on other PowerQUICC's DMA engines
and maybe even for the MPC5200 BestComm, too, with some changes.

> The patch also contains a hackish demo client (dma_demo_client.ko) which is
> performing some dma transfers in the 256th MB of physical memory. So it
> should only be used on a machine with 256MB of memory bootet with mem=255M
> (but changing that should be trivial). The demo client shows well how the
> API works and how much overhead the API adds.
> 
> Any feedback this time?

Sorry, I'm currently busy with some hardware design work.
But if you want to test some code, I can get you an SSH account on my
MPC8540 platform.

Best regards,
-- 
Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com
