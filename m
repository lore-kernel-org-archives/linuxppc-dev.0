Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 48036B6F6B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Aug 2011 01:10:37 +1000 (EST)
Message-ID: <4E414DE8.4050909@grandegger.com>
Date: Tue, 09 Aug 2011 17:10:32 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Robin Holt <holt@sgi.com>
Subject: Re: [PATCH 4/4] [powerpc] Add flexcan device support for p1010rdb.
References: <1312892907-20419-1-git-send-email-holt@sgi.com>
	<1312892907-20419-5-git-send-email-holt@sgi.com>
	<9C64B7751C3BCA41B64A68E23005A7BE1C4A88@039-SN1MPN1-002.039d.mgd.msft.net>
	<20110809145507.GY4926@sgi.com>
In-Reply-To: <20110809145507.GY4926@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "socketcan-core@lists.berlios.de" <socketcan-core@lists.berlios.de>,
	U Bhaskar-B22300 <B22300@freescale.com>,
	PPC list <linuxppc-dev@lists.ozlabs.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/09/2011 04:55 PM, Robin Holt wrote:
> On Tue, Aug 09, 2011 at 02:45:58PM +0000, U Bhaskar-B22300 wrote:
>> Hi Robin,
>> 	Where are you doing the irq handling ie request_irq() for the powerpc based P1010.
>> 	Or the existing code of ARM based FlexCAN will work for P1010 ??
> 
> It appears that the of_device stuff got moved under the struct device
> and that allows the request_irq() to just magically work.

Cool! Actually I was also missing of_address_to_resource (or of_iomap)
and irq_of_parse_and_map(). But the resources seem to be filled in here:

  http://lxr.linux.no/#linux+v3.0.1/drivers/of/platform.c#L121

Wolfgang.
