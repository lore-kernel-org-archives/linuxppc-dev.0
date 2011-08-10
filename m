Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 05930B6F76
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Aug 2011 04:40:05 +1000 (EST)
Message-ID: <4E42D079.7070709@freescale.com>
Date: Wed, 10 Aug 2011 13:39:53 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Robin Holt <holt@sgi.com>
Subject: Re: [PATCH v10 5/5] [powerpc] Fix up fsl-flexcan device tree binding.
References: <1312945564-6626-1-git-send-email-holt@sgi.com>
	<1312945564-6626-6-git-send-email-holt@sgi.com>
	<4E428BFF.7060402@grandegger.com> <20110810141550.GQ4926@sgi.com>
	<9C64B7751C3BCA41B64A68E23005A7BE1C6A21@039-SN1MPN1-002.039d.mgd.msft.net>
	<20110810160054.GT4926@sgi.com> <4E42CCB0.8090803@grandegger.com>
	<4E42CDA8.5050902@freescale.com> <20110810183526.GZ4926@sgi.com>
In-Reply-To: <20110810183526.GZ4926@sgi.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	U Bhaskar-B22300 <B22300@freescale.com>,
	"socketcan-core@lists.berlios.de" <socketcan-core@lists.berlios.de>,
	PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/10/2011 01:35 PM, Robin Holt wrote:
> On Wed, Aug 10, 2011 at 01:27:52PM -0500, Scott Wood wrote:
>> "...and then associate the label with an alias."
>>
>> The alias can then be used if you want "can0" versus "can1".
> 
> Does the alias get used by either the kernel or something else or is it
> just extra detail with no purpose?

It could be used by udev to produce a symlink.  Currently, the major
non-human consumer of the aliases is U-Boot.

-Scott
