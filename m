Return-Path: <jan.damborsky@devcom.cz>
Received: from swip.net (mailfe04.swip.net [212.247.154.97])
	by ozlabs.org (Postfix) with ESMTP id 9DD1467A64
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Feb 2005 00:37:28 +1100 (EST)
Message-ID: <42109B82.9070604@devcom.cz>
Date: Mon, 14 Feb 2005 13:37:22 +0100
From: Jan Damborsky <jan.damborsky@devcom.cz>
MIME-Version: 1.0
To: Markus Westergren <markus.westergren@biologigrand.ac>
References: <Pine.LNX.4.50.0502131246140.3196-100000@220a.licentiaten.umea.hsb.se>
In-Reply-To: <Pine.LNX.4.50.0502131246140.3196-100000@220a.licentiaten.umea.hsb.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Support for Adder875 in Linux 2.4
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Markus Westergren wrote:

>Hi,
>
>I'm working on a project which will use hardware based on Analogue & Micro
>Adder875 module together with Linux 2.4.
>
>I use RedBoot as bootloader and kernel 2.4.27-pre1, both came with the Adder
>module.
>
>The project require:
>
> - dual ethernet support with AM79C874 PHY
>   The driver I've found (fec.c) only supports one ethernet. I'v started
>	modifying a newer version of this driver which have support for my PHY. I
>	have made some progress but it's not working yet. Found out that the first
>	FEC is used to communicate with both PHY's. Both devices are detected
>	correctly and the first seems to work but the second hangs the kernel when
>	the first packet is sent or received.
>  
>
We use our proprietary board with MPC880, dual ethernet + Am79C874 PHY.
Kernel 2.4.25  (linuxppc_2_4_devel checked out from www.denx.de). Original
source tree supports only one FEC, but with minor ugly hack we utilize 
both MPC880 FECs
without problem. If interested, I can send you a patch for get 2nd FEC 
working.
