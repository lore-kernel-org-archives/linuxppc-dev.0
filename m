Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.233])
	by ozlabs.org (Postfix) with ESMTP id 13A9DDDE03
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 00:24:29 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id i30so166638wxd.15
	for <linuxppc-dev@ozlabs.org>; Mon, 05 May 2008 07:24:28 -0700 (PDT)
Message-ID: <fa686aa40805050724w59d4357ak6029a2a7a612329e@mail.gmail.com>
Date: Mon, 5 May 2008 08:24:28 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: monstr@seznam.cz
Subject: Re: [PATCH 04/56] microblaze_v2: Open firmware files
In-Reply-To: <684c36e5ad3f598e5079e88ec195545c4a7150c2.1209897266.git.monstr@monstr.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <a4a778e34c66d126f5c4bf1ca423cf32950ea5ab.1209897266.git.monstr@monstr.eu>
	<684c36e5ad3f598e5079e88ec195545c4a7150c2.1209897266.git.monstr@monstr.eu>
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, arnd@arndb.de,
	matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	linux-kernel@vger.kernel.org,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, will.newton@gmail.com,
	John.Linn@xilinx.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, May 4, 2008 at 5:40 AM,  <monstr@seznam.cz> wrote:
> From: Michal Simek <monstr@monstr.eu>
>
>
>  Signed-off-by: Michal Simek <monstr@monstr.eu>
>  ---
>   arch/microblaze/kernel/prom.c        | 1653 ++++++++++++++++++++++++++++++++++
>   include/asm-microblaze/of_device.h   |   41 +
>   include/asm-microblaze/of_platform.h |   45 +
>   include/asm-microblaze/prom.h        |  311 +++++++

another mostly-clone from arch/powerpc/kernel.  Is anyone working on
moving the guts of this file to a common location?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
