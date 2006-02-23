Return-Path: <tnt@246tNt.com>
Received: from outmx024.isp.belgacom.be (outmx024.isp.belgacom.be
	[195.238.4.128])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5C153679E0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Feb 2006 18:37:09 +1100 (EST)
Received: from outmx024.isp.belgacom.be (localhost [127.0.0.1])
	by outmx024.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id k1N7awar018086
	for <linuxppc-embedded@ozlabs.org>; Thu, 23 Feb 2006 08:36:58 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <43FD6669.9090405@246tNt.com>
Date: Thu, 23 Feb 2006 08:38:17 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: #LI JIANGGAN# <lijianggan@pmail.ntu.edu.sg>
Subject: Re: boot failure on lite5200b board
References: <84A109BF918D934CB46ACF33BCE187C002D54D71@mail02.student.main.ntu.edu.sg>
In-Reply-To: <84A109BF918D934CB46ACF33BCE187C002D54D71@mail02.student.main.ntu.edu.sg>
Content-Type: text/plain; charset=ISO-8859-1
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

#LI JIANGGAN# wrote:
> Hello all,
> 
> For my end-of-study project, I am working on an embedded system with
> reference of freescale's lite5200b reference board. I was trying to boot
> Linux 2.6.15 on the board (with the fec and bestcomm corrected). however
> the booting was stuck at the following stage:

In addition to what has already been said (use a higher address for the
image and don't forget console=ttyPSC0 in kernel command line), make
sure you use the kernel from my git tree, it contains a few patches from
John Rigby to add support for the lite5200b.

Please report if it works, I've not been able to test those myself since
i'm still on lite5200.


	Sylvain
