Return-Path: <hs@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EB302B7334
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 23:52:40 +1000 (EST)
Received: from a.relay.invitel.net (a.relay.invitel.net [62.77.203.3])
	by ozlabs.org (Postfix) with ESMTP id 7381CDDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 23:52:39 +1000 (EST)
Received: from mail.invitel.hu (mail.invitel.hu [213.163.59.4])
	by a.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id
	85F2811A585
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 15:52:37 +0200 (CEST)
Received: from [192.168.1.6] ([87.97.84.156])
	by mail.invitel.hu (Invitel Messaging Server)
	with ESMTPA id <0KOQ00JJZBVORKE0@invitel.hu> for
	linuxppc-dev@ozlabs.org; Fri, 21 Aug 2009 15:52:37 +0200 (CEST)
Date: Fri, 21 Aug 2009 15:59:16 +0200
From: Heiko Schocher <hs@denx.de>
Subject: Re: 832x: MATH_EMUL
In-reply-to: <alpine.LRH.2.00.0908211545170.16485@vixen.sonytel.be>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Message-id: <4A8EA834.70309@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15
References: <4A8E4128.6040905@denx.de>
	<1059A1F2-B4AA-48DC-82D6-B26D39414FA4@kernel.crashing.org>
	<alpine.LRH.2.00.0908211545170.16485@vixen.sonytel.be>
Cc: linuxppc-dev@ozlabs.org, Detlev Zundel <dzu@denx.de>
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Geert,

Geert Uytterhoeven wrote:
> On Fri, 21 Aug 2009, Kumar Gala wrote:
>> On Aug 21, 2009, at 1:39 AM, Heiko Schocher wrote:
>>> I actually porting a mpc8321 based port, and because there is no FPU
>>> on this CPU, I activated MATH_EMUL, as all other mpc832x ports did.
>>>
>>> Is there something like a counter, which counts how many times this
>>> Exception occurs?
>> Geert published some patches that did something like this but there isn't
>> upstream as far as I know at this point.
> 
> It's upstream: 80947e7c99c29ce3a78bdc1933b310468455a82f

Thanks for this info!

bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
