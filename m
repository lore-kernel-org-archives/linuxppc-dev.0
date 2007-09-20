Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay011.isp.belgacom.be (mailrelay011.isp.belgacom.be
	[195.238.6.178]) by ozlabs.org (Postfix) with ESMTP id ABE2CDDDF5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Sep 2007 21:44:43 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: samppa@sundmangroup.com
Subject: Re: 8270 & Watchdog - early start - II
Date: Thu, 20 Sep 2007 13:44:40 +0200
References: <AEA1A32F001C6B4F98614B5B80D7647D02D73DEB@esealmw115.eemea.ericsson.se>
	<200709201322.08359.laurentp@cse-semaphore.com>
	<14733.194.237.142.6.1190286678.squirrel@www.sundmangroup.com>
In-Reply-To: <14733.194.237.142.6.1190286678.squirrel@www.sundmangroup.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709201344.40653.laurentp@cse-semaphore.com>
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

On Thursday 20 September 2007 13:11, samppa@sundmangroup.com wrote:
> > You still shouldn't use direct access with MMU enabled. Use the global
> > CPM mapping and the I/O access macros.
>
> I understand, but I need to kick on the WDT before "cpm2_immr"
> is initialized dur to timing constraints.

You can then probably get away with the BAT mapping. However you should sti=
ll=20
use the I/O access macro out_be16.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75
