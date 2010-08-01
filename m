Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f170.google.com (mail-yx0-f170.google.com
	[209.85.213.170]) by ozlabs.org (Postfix) with ESMTP id 31A581007D1
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Aug 2010 18:08:31 +1000 (EST)
Received: by yxi11 with SMTP id 11so1731737yxi.15
	for <linuxppc-dev@ozlabs.org>; Sun, 01 Aug 2010 01:08:30 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100801.010501.27813939.davem@davemloft.net>
References: <20100801074831.1099.3318.stgit@angua>
	<20100801.010501.27813939.davem@davemloft.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 1 Aug 2010 02:08:10 -0600
Message-ID: <AANLkTinkfaDt5HWDby8W1gnms6VZ7DQcpTGu=0AUnx1B@mail.gmail.com>
Subject: Re: [PATCH] of/device: Replace struct of_device with struct
	of_platform
To: David Miller <davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	sparclinux@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Aug 1, 2010 at 2:05 AM, David Miller <davem@davemloft.net> wrote:
>
> Subject should say "struct platform_device" not "struct of_platform",
> I think :-)

Gah!  yup, will fix.  Thanks.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
