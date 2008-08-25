Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 53716DE86D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Aug 2008 01:41:41 +1000 (EST)
Message-ID: <48B2D190.1020106@freescale.com>
Date: Mon, 25 Aug 2008 10:36:48 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: roger blofeld <blofeldus@yahoo.com>
Subject: Re: [PATCH V2] MPC52XX: Don't touch pipelining for MPC5200B
References: <957941.2462.qm@web53504.mail.re2.yahoo.com>
In-Reply-To: <957941.2462.qm@web53504.mail.re2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Wolfram Sang <w.sang@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

roger blofeld wrote:
> Hi
>  Since this bug is ATA specific, shouldn't this code be conditioned by CONFIG_IDE ?

And then what happens if IDE is built as a module?

-Scott
