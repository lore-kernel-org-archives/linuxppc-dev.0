Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8EA9FDDF60
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 08:56:05 +1100 (EST)
Message-ID: <47912088.4040507@scram.de>
Date: Fri, 18 Jan 2008 22:56:24 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH/RFCv2] [POWERPC] Add support for freescale watchdog to
	CPM serial driver.
References: <478F4AE3.5090803@scram.de>
	<20080118183905.2d5d8474@lxorguk.ukuu.org.uk>
	<4790F44F.8020009@scram.de>
	<20080118204030.48fbb683@lxorguk.ukuu.org.uk>
	<EC416CBA-9200-4D71-8D95-39798937203D@kernel.crashing.org>
In-Reply-To: <EC416CBA-9200-4D71-8D95-39798937203D@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kumar,

>> Ok now that makes sense, thanks
> 
> So I'll ask, what serial input are you waiting for from the boot wrapper?

It's the editor for the kernel command line.

Thanks,
Jochen
