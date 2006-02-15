Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 86423679F2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Feb 2006 05:36:53 +1100 (EST)
Date: Wed, 15 Feb 2006 10:36:44 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: ????????? <lonsn@163.com>
Subject: Re: Gigabit ethernet support of ppc440gx in 2.6 and 2.4
Message-ID: <20060215183644.GB2944@gate.ebshome.net>
References: <43F2CF5D.2AFC8D.22998>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43F2CF5D.2AFC8D.22998>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Feb 15, 2006 at 02:08:52PM +0800, ????????? wrote:
> We want to get a data rate of 600Mbits/s over gigabit ethernet of ppc440gx.
> How about the status of support to ppc440gx GigE in Linux kernel?
> Which kernel version should we select? 2.6 or 2.4?

GigE support for 440GX is in official 2.6. Patch for 2.4 is available 
at http://kernel.ebshome.net. If you don't feel comfortable dealing 
with kernel patches, I'd recommend 2.6

Effective Ethernet throughput highly depends on packet size. For some 
small packet sizes 600Mb/s is theoretically impossible over GigE.

I achieved 900+ Mb/s TCP throughput with my driver (packets around 4K 
long) and using sendfile(2) based test application.

-- 
Eugene
