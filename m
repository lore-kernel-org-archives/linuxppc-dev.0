Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0A91BDDDF0
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Nov 2008 21:57:34 +1100 (EST)
Message-ID: <490ED8EF.1010504@embedded-sol.com>
Date: Mon, 03 Nov 2008 12:56:47 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Sean MacLennan <smaclennan@pikatech.com>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] ndfc driver
References: <9293074.419171225391386417.JavaMail.nabble@isper.nabble.com>	<20081030195858.28900ee5@lappy.seanm.ca>	<490D68A8.4060905@embedded-sol.com>	<20081102124804.15003002@lappy.seanm.ca>	<490E02D7.5050402@embedded-sol.com>	<20081102145811.6da10ef4@lappy.seanm.ca>	<490E074F.5050909@embedded-sol.com>	<20081102152958.42e88283@lappy.seanm.ca>	<490E4D0D.9060207@embedded-sol.com>
	<20081102204510.3d8e71f2@lappy.seanm.ca>
In-Reply-To: <20081102204510.3d8e71f2@lappy.seanm.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I can confirm that this driver works fine on custom
4060EX board. The NAND is 256MiB Samsumg,
with 2K page size. I had to modify U-boot to provide
EBC "ranges" property for NAND, but otherwise
it worked from the beginning.

I didn't see any reaction to Sean's post, but this
driver is important IMHO, since several in-tree 44X
boards (e.g Canyonlands and Glacier) lack NAND
support, and Warp uses old platform device model
for its NAND.

Felix Radensky
Embedded Solutions Ltd.
http://www.embedded-sol.com
