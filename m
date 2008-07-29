Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de",
	Issuer "StartCom Class 1 Primary Intermediate Server CA" (not
	verified)) by ozlabs.org (Postfix) with ESMTPS id AC9D3DDED7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Jul 2008 19:19:36 +1000 (EST)
Message-ID: <488EE097.5080305@scram.de>
Date: Tue, 29 Jul 2008 11:19:19 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Fabien Oriede <fabien.oriede@yahoo.fr>
Subject: Re: No output from SCC1 console
References: <828666.17571.qm@web27407.mail.ukl.yahoo.com>
In-Reply-To: <828666.17571.qm@web27407.mail.ukl.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Fabien,

> In my
> U-Boot's environnement variables, I have "bootargs=console=ttyS0,38400".

Make this console=ttyCPM0,38400

> < 6 > ttyCPM0 at MMIO 0xffe00a00 (irq = 46) is a CPM UART –

Thanks,
Jochen
