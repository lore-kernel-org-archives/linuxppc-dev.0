Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 87606DDF3D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Aug 2008 07:48:13 +1000 (EST)
Message-ID: <48B71D04.4080805@embedded-sol.com>
Date: Fri, 29 Aug 2008 00:47:48 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: GPIO interrupt on AMCC 460EX
References: <48B6B201.2070101@embedded-sol.com> <200808281720.13138.sr@denx.de>
In-Reply-To: <200808281720.13138.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi, Stefan

Stefan Roese wrote:
> arch/powerpc now used virtual interrupts. You need to include this hardware 
> interrupt number into your device-tree (create a new node for your CPLD) and 
> extract the virtual irq number from there by calling irq_of_parse_and_map().
>
>   
That works fine, thank you.

Felix.
