Return-Path: <richard.rojfors@mocean-labs.com>
Received: from proxy3.bredband.net (proxy3.bredband.net [195.54.101.73])
	by ozlabs.org (Postfix) with ESMTP id BB275B7B8F
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 04:43:10 +1100 (EST)
Received: from ipb1.telenor.se (195.54.127.164) by proxy3.bredband.net
	(7.3.140.3) id 4AD3E1BA00CCCE67 for linuxppc-dev@ozlabs.org;
	Thu, 12 Nov 2009 18:22:40 +0100
Message-ID: <4AFC4460.9050508@mocean-labs.com>
Date: Thu, 12 Nov 2009 18:22:40 +0100
From: =?ISO-8859-1?Q?Richard_R=F6jfors?=
 <richard.rojfors@mocean-labs.com>
MIME-Version: 1.0
To: John Linn <John.Linn@xilinx.com>
Subject: Re: [PATCH v2 1/4] xilinx_spi: Split into of driver and generic part.
References: <4AFC1B1E.60304@mocean-labs.com>
	<fa686aa40911120656x3b94b9c7tfabd6e7956ed41fb@mail.gmail.com>
	<38eacaec-f0d3-436c-b461-40b5d795cdd9@VA3EHSMHS009.ehs.local>
In-Reply-To: <38eacaec-f0d3-436c-b461-40b5d795cdd9@VA3EHSMHS009.ehs.local>
Content-Type: text/plain; charset=ISO-8859-1
Cc: spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>,
	dbrownell@users.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/12/09 6:17 PM, John Linn wrote:
>> Have you compile tested this?  platform_data is a void*, the
>> dereference will not work.  I know you don't have hardware; but
>> getting the needed cross compiler is easy.
> 
> Here's the fixes I did to make it compile. On to testing :)

Great! I tested this against a max7301 GPIO expander.

--Richard
