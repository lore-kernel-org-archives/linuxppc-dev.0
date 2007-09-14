Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 0F40ADDE17
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Sep 2007 01:55:50 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 1/2] [POWERPC] Add SCC clock support to cpm2_clk_setup()
Date: Fri, 14 Sep 2007 17:55:45 +0200
References: <200707111517.52663.laurent.pinchart@technotrade.biz>
In-Reply-To: <200707111517.52663.laurent.pinchart@technotrade.biz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709141755.45559.laurentp@cse-semaphore.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> On Sep 13, 2007, at 8:53 AM, Laurent Pinchart wrote:
>> On Wednesday 11 July 2007 15:17, Laurent Pinchart wrote:
>>> cpm2_clk_setup() supports setting FCC clocks only, even though the
>>> cpm_clk_target enumeration lists SCC clocks. This patch adds SCC =20
>>> clock support.
>>
>> Any chance this patch (and its 2/2 brother) could be committed ?
>
> Have you looked at Scott Wood's cleanup patches.  They seem to do =20
> some of this.

Where can I find them ? I checked in

git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6

and found nothing relevant.

Best regard,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75
