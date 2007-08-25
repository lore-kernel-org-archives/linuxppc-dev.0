Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7B7BBDDE9D
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Aug 2007 19:51:39 +1000 (EST)
In-Reply-To: <20070825092954.4087.95333.stgit@localhost.localdomain>
References: <20070825091440.4087.1428.stgit@localhost.localdomain>
	<20070825092954.4087.95333.stgit@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <15d18697dc6fe8e930deb1880daad3b6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/3] [POWERPC] Add pci node to sequoia dts
Date: Sat, 25 Aug 2007 11:51:26 +0200
To: Vitaly Bordug <vitb@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +			compatible = "ibm, 440epx";

Oh, and shouldn't it be "amcc," anyway?


Segher
