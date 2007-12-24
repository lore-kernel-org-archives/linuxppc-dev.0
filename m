Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 2718ADDDFA
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Dec 2007 23:15:37 +1100 (EST)
Date: Mon, 24 Dec 2007 15:17:15 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] [POWERPC] MPC8360E-RDK: Device tree and board file
Message-ID: <20071224121715.GB7903@localhost.localdomain>
References: <20071221202309.GA4557@localhost.localdomain>
	<476DD5DF.5020806@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <476DD5DF.5020806@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Dec 22, 2007 at 09:28:31PM -0600, Timur Tabi wrote:
> Anton Vorontsov wrote:
> 
> >+	qe@e0100000 {
> >+		#address-cells = <1>;
> >+		#size-cells = <1>;
> >+		compatible = "fsl,qe";
> >+		ranges = <0 0xe0100000 0x00100000>;
> >+		reg = <0xe0100000 0x480>;
> >+		/* filled by u-boot */
> >+		brg-frequency = <0>;
> 
> You need "bus-frequency" here too

Hm.. 

http://ozlabs.org/pipermail/linuxppc-dev/2007-December/048388.html

^^ David Gibson suggested to get rid of it.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
