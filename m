Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 65AD1DE055
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jul 2008 05:34:11 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m6TJXsq1014722 for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Jul 2008 12:33:55 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m6TJXrGi004216
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Jul 2008 14:33:53 -0500 (CDT)
Date: Tue, 29 Jul 2008 14:33:52 -0500
From: Scott Wood <scottwood@freescale.com>
To: Fabien Oriede <fabien.oriede@yahoo.fr>
Subject: Re: No output from SCC1 console
Message-ID: <20080729193352.GA8051@ld0162-tx32.am.freescale.net>
References: <828666.17571.qm@web27407.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <828666.17571.qm@web27407.mail.ukl.yahoo.com>
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

On Tue, Jul 29, 2008 at 08:47:00AM +0000, Fabien Oriede wrote:
> < 6 > cpm_uart : WARNING : no UART devices found on platorm bus! – 
> < 6 > cpm_uart : the driver will guess configuration, but this mode is no longer supported. – 

Enable CONFIG_PPC_CPM_NEW_BINDING (or better, upgrade to the latest
kernel), and ensure that the device tree node and pin/brg setup is
correct.

Try commenting out calls to set the BRG as a test, to see if it's getting
a bad frequency.

-Scott
