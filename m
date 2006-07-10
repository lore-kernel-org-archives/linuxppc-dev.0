Return-Path: <sr@denx.de>
Received: from natklopstock.rzone.de (natklopstock.rzone.de [81.169.145.174])
	by ozlabs.org (Postfix) with ESMTP id EB97C67B7B
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Jul 2006 20:56:36 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Failed to initialize the ethernet on PPC4 40GP
Date: Mon, 10 Jul 2006 12:42:28 +0200
References: <44B220CB.000108.31873@bj163app12.163.com>
In-Reply-To: <44B220CB.000108.31873@bj163app12.163.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200607101242.29359.sr@denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Denny,

On Monday 10 July 2006 11:41, Denny wrote:
>     Does anyone ecounter this failure,it always tell me "No ethernet
> found", why?

Is this question linux or U-Boot related? If linux then you may have not 
enabled the 4xx ethernet support in your kernel configuration. If U-Boot, 
then please set the MAC addresses (ethaddr and eth1addr) and reset the board. 
And if it really is an U-Boot question, you should address the correct 
mailinglist.

Best regards,
Stefan
