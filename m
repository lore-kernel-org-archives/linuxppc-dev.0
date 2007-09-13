Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay012.isp.belgacom.be (mailrelay012.isp.belgacom.be
	[195.238.6.179]) by ozlabs.org (Postfix) with ESMTP id 1DFB3DDDFD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Sep 2007 23:53:17 +1000 (EST)
Received: from mail.technotrade.biz (localhost [127.0.0.1])
	by mail.technotrade.biz (Postfix) with ESMTP id EE5C02CF5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Sep 2007 15:53:12 +0200 (CEST)
Received: from pclaurent.technotrade.biz (pclaurent.technotrade.biz
	[192.168.1.47])
	by mail.technotrade.biz (Postfix) with ESMTP id DF1851F7D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Sep 2007 15:53:12 +0200 (CEST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 1/2] [POWERPC] Add SCC clock support to cpm2_clk_setup()
Date: Thu, 13 Sep 2007 15:53:11 +0200
References: <200707111517.52663.laurent.pinchart@technotrade.biz>
In-Reply-To: <200707111517.52663.laurent.pinchart@technotrade.biz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709131553.11853.laurentp@cse-semaphore.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 11 July 2007 15:17, Laurent Pinchart wrote:
> cpm2_clk_setup() supports setting FCC clocks only, even though the
> cpm_clk_target enumeration lists SCC clocks. This patch adds SCC clock
> support.

Any chance this patch (and its 2/2 brother) could be committed ?

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75
