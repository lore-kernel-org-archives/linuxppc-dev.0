Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 561C0B70A8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Nov 2010 19:46:11 +1100 (EST)
Subject: RE: [PATCH v1] ppc44x:PHY fixup for USB on canyonlands board
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rupjyoti Sarmah <rsarmah@apm.com>
In-Reply-To: <602c780cd2a81ee32f834a82814fe77f@mail.gmail.com>
References: <201011231256.oANCur3N016433@amcc.com>
	<201011231421.02377.sr@denx.de>
	<602c780cd2a81ee32f834a82814fe77f@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 24 Nov 2010 18:32:46 +1100
Message-ID: <1290583966.32570.90.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-11-24 at 10:25 +0530, Rupjyoti Sarmah wrote:
> 
> So, do you suggest to move this macro to the canyonlands.c ? Or
> introduce
> canyonlands.h ?

Just move it to the .c file.

Cheers,
Ben.
