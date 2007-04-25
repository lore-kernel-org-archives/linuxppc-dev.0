Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuu212123311.barco.com [212.123.3.11])
	by ozlabs.org (Postfix) with SMTP id F1A17DDEDB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Apr 2007 22:03:12 +1000 (EST)
Received: from peko by sleipner.barco.com with local (Exim 4.60)
	(envelope-from <jacmet@sunsite.dk>) id 1HggD8-0004T3-BB
	for linuxppc-embedded@ozlabs.org; Wed, 25 Apr 2007 14:03:02 +0200
From: Peter Korsgaard <peter.korsgaard@barco.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 1/5] [PPC] Rework Kconfig dependancies for Xilinx Virtex
	ppc405 platform
References: <1176622062492-git-send-email-grant.likely@secretlab.ca>
	<11766220692537-git-send-email-grant.likely@secretlab.ca>
Date: Wed, 25 Apr 2007 14:03:02 +0200
In-Reply-To: <11766220692537-git-send-email-grant.likely@secretlab.ca> (Grant
	Likely's message of "Sun, 15 Apr 2007 01:27:38 -0600")
Message-ID: <87hcr4acg9.fsf@sleipner.barco.com>
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

GL> Reverse dependency order for Xilinx Virtex parts.  For these
GL> parts, It makes more sense for boards/chips to specify which
GL> features they provide instead of the features listing the parts
GL> they are implemented in.  I think it also makes adding new board
GL> ports simpler.

GL> Signed-off-by: Grant Likely <grant.likely@secretlab.ca> ---

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
