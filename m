Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (amanaus.varma-el.com [195.144.240.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.varma-el.com",
	Issuer "mail.varma-el.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B16C267CEE
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Oct 2006 17:29:20 +1000 (EST)
Message-ID: <4541B547.1010908@varma-el.com>
Date: Fri, 27 Oct 2006 11:29:11 +0400
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: RPo <rainer.poisel@kirchnersoft.com>
Subject: Re: MPC5200 (Board: PM520) I2C Problem
References: <F05B338A1B21D9119FFF0004761A51136AB28E@exchange-server.ow.ks>
In-Reply-To: <F05B338A1B21D9119FFF0004761A51136AB28E@exchange-server.ow.ks>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Rainer
RPo wrote:
> Hi,
> 
> I'm currently using the MPC5200 based board "PM520" and 
> want to access the I2C bus. To do so, I attached a PCF8574P
> to the bus. But I was not successful in setting the outputs
> of this IC. 
<...snip..>

Revision of MPC5200? (third string engraved on the MPC)
If L25R then check this doco:
   http://www.freescale.com/files/32bit/doc/errata/MPC5200E.pdf
(if be short - I2C didn't work on this revision chips)

--
Regards
Andrey Volkov
