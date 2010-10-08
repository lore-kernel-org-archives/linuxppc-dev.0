Return-Path: <david.hagood@gmail.com>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179]) by ozlabs.org (Postfix) with ESMTP id D3F41B6EFE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Oct 2010 22:16:17 +1100 (EST)
Received: by yxs7 with SMTP id 7so356324yxs.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 08 Oct 2010 04:16:15 -0700 (PDT)
Subject: Re: Parsing a bus fault message?
From: David Hagood <david.hagood@gmail.com>
To: "tiejun.chen" <tiejun.chen@windriver.com>
In-Reply-To: <4CAEE2EC.2020103@windriver.com>
References: <2bef2051c143a8d6e619519b222016f9.squirrel@localhost>
	<20100928153153.GA22485@ovro.caltech.edu>
	<20100928134554.323667e5@udp111988uds.am.freescale.net>
	<4CA2FDA3.20704@windriver.com>
	<af75f13d9ed8beb29470dffe56d295f5.squirrel@localhost>
	<4CAEE2EC.2020103@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 08 Oct 2010 06:16:12 -0500
Message-ID: <1286536572.2545.16.camel@chumley>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
	"Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-10-08 at 17:22 +0800, tiejun.chen wrote:
> 
> I think it should be allowed to use two LAWs to map different space for PCIe
> since I ever saw more one LAWs are created for different RAM space.
> 
> Sorry for this delay response.
> 
> -Tiejun

It's my bad, as I'd worked out the problem: the host root complex had to
be forced to rescan the device and enable bus mastering on that side of
things. Once that happened, I could access PCI space.

I should have posted my success.
