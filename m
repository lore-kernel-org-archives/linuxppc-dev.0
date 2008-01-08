Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id D7DC8DDE2B
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 13:07:21 +1100 (EST)
Message-ID: <4782DAD8.1080104@pikatech.com>
Date: Mon, 07 Jan 2008 21:07:20 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: How complete should the DTS be?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Just a general question about DTS "completeness". Like all 440EP 
processors, the taco has two i2c buses. However, only one bus has 
anything connected to it.

Should I show both bus entries in the DTS, or only the one that is used? 
I have generally only been showing the devices that are present. i.e. 
Only one emac, only one serial port.

Is there a convention for this?

Cheers,
   Sean
