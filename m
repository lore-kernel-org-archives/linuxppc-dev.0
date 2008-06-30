Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AECEBDDEFD
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 02:28:25 +1000 (EST)
In-Reply-To: <4117.6640-711-1819091302-1214810290@seznam.cz>
References: <4117.6640-711-1819091302-1214810290@seznam.cz>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <387e5af6a3d9efd2b982dbc32e8e0338@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 19/60] microblaze_v4: checksum support
Date: Mon, 30 Jun 2008 18:25:08 +0200
To: Michal Simek <Monstr@seznam.cz>
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
	vapier.adi@gmail.com, arnd@arndb.de, matthew@wil.cx,
	microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org,
	John.Linn@xilinx.com, linuxppc-dev@ozlabs.org,
	alan@lxorguk.ukuu.org.uk, hpa@zytor.com, drepper@redhat.com,
	john.williams@petalogix.com, will.newton@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> you find bug because there is microblaze asm code in generic folder.

No, I found it because I was reading the code, I didn't even notice
this was in asm-generic :-)

> Big thanks. I'll fix it and I'll look at parameters too.

Thanks.


Segher
