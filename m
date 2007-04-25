Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuu212123311.barco.com [212.123.3.11])
	by ozlabs.org (Postfix) with SMTP id D940BDDF29
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Apr 2007 22:12:26 +1000 (EST)
Received: from peko by sleipner.barco.com with local (Exim 4.60)
	(envelope-from <jacmet@sunsite.dk>) id 1HggMB-0004cw-Nc
	for linuxppc-embedded@ozlabs.org; Wed, 25 Apr 2007 14:12:23 +0200
From: Peter Korsgaard <peter.korsgaard@barco.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 4/5] [PPC] Stop using ppc_sys for Xilinx Virtex boards
References: <1176622062492-git-send-email-grant.likely@secretlab.ca>
	<11766220692537-git-send-email-grant.likely@secretlab.ca>
	<11766220693636-git-send-email-grant.likely@secretlab.ca>
	<1176622070387-git-send-email-grant.likely@secretlab.ca>
	<11766220702647-git-send-email-grant.likely@secretlab.ca>
Date: Wed, 25 Apr 2007 14:12:23 +0200
In-Reply-To: <11766220702647-git-send-email-grant.likely@secretlab.ca> (Grant
	Likely's message of "Sun, 15 Apr 2007 01:27:41 -0600")
Message-ID: <874pn4ac0o.fsf@sleipner.barco.com>
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

GL> The arch/ppc/syslib/ppc_sys.c infrastructure does not work well
GL> for the virtex ports.  Move the ml300 and ml403 board ports over
GL> to use the new virtex_devices infrastructure.

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
