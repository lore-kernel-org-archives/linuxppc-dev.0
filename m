Return-Path: <carcadiz@hotmail.com>
Received: from bay0-omc3-s36.bay0.hotmail.com (bay0-omc3-s36.bay0.hotmail.com
	[65.54.246.236]) by ozlabs.org (Postfix) with ESMTP id 02E20DDE0E
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Mar 2007 21:12:51 +1100 (EST)
Message-ID: <BAY122-F66F0C1E4D2F887354451FCA760@phx.gbl>
In-Reply-To: <45FE5C63.5040800@fechner.net>
From: "Pedro Luis D. L." <carcadiz@hotmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Howto set DIO on MPC-5200 Lite
Date: Mon, 19 Mar 2007 11:12:45 +0100
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Matthias Fechner wrote on Mon, 19 Mar 2007 10:48:19
>
>Hi Pedro and Sylvain,
>
>Pedro Luis D. L. wrote:
> > Could you mean "GIO" ports?
>
>I mean the digital IO ports ok or general IO ports.
>What I want is to set a signal to high or low which should control a 
>relais.
>
>I thought I can use the pin Dxx for that on the board.
>
>Best regards,
>Matthias

The digital IO ports in the MPC5200 Lite are called GPIO ports. You can use 
some pins in the PSC ports and some Timers as General Purpose IO ports.
You need to define the behaviour of these ports in the Port Config register 
or the Timer registers.


Best,
Pedro L.

_________________________________________________________________
Acepta el reto MSN Premium: Protección para tus hijos en internet. 
Descárgalo y pruébalo 2 meses gratis. 
http://join.msn.com?XAPID=1697&DI=1055&HL=Footer_mailsenviados_proteccioninfantil
