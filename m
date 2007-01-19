Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 210EBDDE3F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Jan 2007 08:07:11 +1100 (EST)
Message-ID: <45B132FC.9070208@freescale.com>
Date: Fri, 19 Jan 2007 15:07:08 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Russell McGuire <rmcguire@uwbt.com>
Subject: Re: MPC83xx:  ns16550.c - 'SERIAL_PORT_DFNS' undeclared?
References: <000801c73c00$01d6cf30$6405a8c0@absolut>	<1169236694.3029.49.camel@saruman.qstreams.net>
	<001001c73c06$5fbf2060$6405a8c0@absolut>
In-Reply-To: <001001c73c06$5fbf2060$6405a8c0@absolut>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Russell McGuire wrote:
> Ben,
> 
> That could be the problem
> 
> I am building using ARCH=ppc
> 
> What is the difference between the two?

Short answer: ppc is deprecated in favor of powerpc.

Eventually, ppc will go away altogether.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
