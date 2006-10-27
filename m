Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (amanaus.varma-el.com [195.144.240.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.varma-el.com",
	Issuer "mail.varma-el.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id AFFDE67CC3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Oct 2006 22:45:02 +1000 (EST)
Message-ID: <4541FF48.1020204@varma-el.com>
Date: Fri, 27 Oct 2006 16:44:56 +0400
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: Roman Fietze <roman.fietze@telemotive.de>
Subject: Re: MPC5200 (Board: PM520) I2C Problem
References: <F05B338A1B21D9119FFF0004761A51136AB28E@exchange-server.ow.ks>	<4541B547.1010908@varma-el.com>
	<200610271315.19077.roman.fietze@telemotive.de>
In-Reply-To: <200610271315.19077.roman.fietze@telemotive.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Roman Fietze wrote:
> Hello,
> 
> On Friday 27 October 2006 09:29, Andrey Volkov wrote:
> 
>> Revision of MPC5200? (third string engraved on the MPC)
>> If L25R then check this doco:
>>    http://www.freescale.com/files/32bit/doc/errata/MPC5200E.pdf
>> (if be short - I2C didn't work on this revision chips)
> 
> We have an "MPC5200CBV400 L25R Rev 2" on our boards, and we
> successfully drive a PCF8563 real time clock and an UDA1380 Codec on
> the same line.
> 
> The problems described in the errata are an arbitration loss problem
> and, depending on teh chp's Rev, a clock noise problem.
> 
> Probably your problem is related to the connected I2C client?
Problem was not in noise. Chips of this rev. _sometime_ didn't
generate clock in ACK/NAK phase. Such behavior acceptable for
a RTC (you could reread clock, after timeout), but for eeprom - not.

--
Regards
Andrey
