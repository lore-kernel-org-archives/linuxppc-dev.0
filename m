Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuumail.barco.com [32.58.34.195])
	by ozlabs.org (Postfix) with SMTP id 6AB40DDE49
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Aug 2007 17:17:16 +1000 (EST)
Received: from peko by sleipner.barco.com with local (Exim 4.60)
	(envelope-from <jacmet@sunsite.dk>) id 1IJOk1-0008MS-2C
	for linuxppc-embedded@ozlabs.org; Fri, 10 Aug 2007 09:17:01 +0200
From: Peter Korsgaard <peter.korsgaard@barco.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Consolidate XILINX_VIRTEX board support
References: <20070806225642.7D72A7B005B@mail34-fra.bigfish.com>
	<87vebryfrv.fsf@sleipner.barco.com>
	<fa686aa40708091157y3c8c0725kbf25ce8a636d5c27@mail.gmail.com>
Date: Fri, 10 Aug 2007 09:17:01 +0200
In-Reply-To: <fa686aa40708091157y3c8c0725kbf25ce8a636d5c27@mail.gmail.com>
	(Grant Likely's message of "Thu, 9 Aug 2007 12:57:40 -0600")
Message-ID: <878x8jx3iq.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "GL" == Grant Likely <grant.likely@secretlab.ca> writes:

Hi,

WR> -boot-$(CONFIG_XILINX_ML300)        += embed_config.o
WR> -boot-$(CONFIG_XILINX_ML403)        += embed_config.o
WR> +boot-$(CONFIG_XILINX_VIRTEX)       += embed_config.o
>> 
>> Don't do that. Other boards with Xilinx FPGAs don't necessarily need
>> embed_config.c

GL> Then post patches for those boards so we can properly support the
GL> different configuration.

Also if the boards are not generally available? No problem for me, but
I don't quite see the point.

-- 
Bye, Peter Korsgaard
