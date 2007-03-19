Return-Path: <tnt@246tNt.com>
Received: from outmx005.isp.belgacom.be (outmx005.isp.belgacom.be
	[195.238.4.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 90712DDEC5
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Mar 2007 21:14:38 +1100 (EST)
Received: from outmx005.isp.belgacom.be (localhost [127.0.0.1])
	by outmx005.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l2JAEWJ0023367
	for <linuxppc-embedded@ozlabs.org>; Mon, 19 Mar 2007 11:14:32 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45FE627E.3050004@246tNt.com>
Date: Mon, 19 Mar 2007 11:14:22 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org, idefix@fechner.net
Subject: Re: Howto set DIO on MPC-5200 Lite
References: <BAY122-F7DD64EA831188A2BEA9FACA760@phx.gbl>
	<45FE5C63.5040800@fechner.net>
In-Reply-To: <45FE5C63.5040800@fechner.net>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Matthias Fechner wrote:
> Hi Pedro and Sylvain,
>
> Pedro Luis D. L. wrote:
>   
>> Could you mean "GIO" ports?
>>     
>
> I mean the digital IO ports ok or general IO ports.
> What I want is to set a signal to high or low which should control a relais.
>
> I thought I can use the pin Dxx for that on the board.
>
> Best regards,
> Matthias
>   
Well, just lookup the schematics to which port the pin you want to
control is connected, then look in the datasheet how to control the
GPIO. You must make sure the port you want to control is in gpio mode in
port_config register, then setup it as output and drive a value onto it
... There is nothing currently in place to do that easily from userspace ...

    Sylvain
