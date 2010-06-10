Return-Path: <wmb@firmworks.com>
Received: from rs35.luxsci.com (rs35.luxsci.com [66.216.127.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 02A0B100B19
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Jun 2010 03:15:59 +1000 (EST)
Message-ID: <4C111C34.1010708@firmworks.com>
Date: Thu, 10 Jun 2010 13:09:08 -0400
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 6/6] of/device: populate platform_device
	(of_device)	resource table on allocation
References: <AANLkTilpUi1cazljWSFbzliY78RKyHUlvBshUD3NPHPv@mail.gmail.com>	<20100610.091357.513168276793712624.imp@bsdimp.com>	<20100610154741.GA7484@oksana.dev.rtsoft.ru>	<20100610.100140.8559628065321695.imp@bsdimp.com>
	<20100610165243.GA18043@oksana.dev.rtsoft.ru>
In-Reply-To: <20100610165243.GA18043@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: sfr@canb.auug.org.au, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, jeremy.kerr@canonical.com,
	linuxppc-dev@lists.ozlabs.org, "M. Warner Losh" <imp@bsdimp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wow, there is some serious bikeshedding going on with this argument 
about structures and arrays .
