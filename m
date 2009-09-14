Return-Path: <hs@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5E428B70CF
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Sep 2009 23:55:02 +1000 (EST)
Received: from b.relay.invitel.net (b.relay.invitel.net [62.77.203.4])
	by ozlabs.org (Postfix) with ESMTP id EA9D5DDD01
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 23:55:00 +1000 (EST)
Received: from mail.invitel.hu (mail.invitel.hu [213.163.59.4])
	by b.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id
	B7BAE31A2D6
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 15:54:57 +0200 (CEST)
Received: from [192.168.1.6] ([82.131.207.169])
	by mail.invitel.hu (Invitel Messaging Server)
	with ESMTPA id <0KPY00LIPRZKRPV0@invitel.hu> for
	linuxppc-dev@ozlabs.org; Mon, 14 Sep 2009 15:54:57 +0200 (CEST)
Date: Mon, 14 Sep 2009 16:09:32 +0200
From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH] mpc5200: support for the MAN mpc5200 based board	mucmc52
In-reply-to: <20090914080322.GA3164@pengutronix.de>
To: Wolfram Sang <w.sang@pengutronix.de>
Message-id: <4AAE4E9C.6080004@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15
References: <4AADF93C.3030604@denx.de> <20090914080322.GA3164@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Wolfram,

Wolfram Sang wrote:
> Hi,
> 
>> +		mpc5200_pic: interrupt-controller@500 {
>> +			// 5200 interrupts are encoded into two levels;
> 
> Grant, maybe this comment could be dropped also for the in-kernel dts-files? I
> think it is sufficently described in mpc5200.txt. I could prepare a patch if
> you agree.
> 
>> +		i2c@3d40 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			compatible = "fsl,mpc5200-i2c","fsl-i2c";
>> +			reg = <0x3d40 0x40>;
>> +			interrupts = <2 16 0>;
>> +			fsl5200-clocking;
> 
> Please drop the clocking-line. It became obsolete.

OK, I fix this.

Thanks for reviewing

bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
