Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D03E1DDEFB
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 08:54:31 +1100 (EST)
Message-ID: <47912016.9040907@freescale.com>
Date: Fri, 18 Jan 2008 15:54:30 -0600
From: Scott Wood <scottwood@freescale.com>
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> So I'll ask, what serial input are you waiting for from the boot wrapper?

The bootwrapper has a command line editing prompt.  It's fairly 
gratuitous in the presence of semi-decent firmware, but it's there 
nonetheless.

-Scott
