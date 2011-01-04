Return-Path: <seanm@seanm.ca>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 6C939B7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Jan 2011 08:33:38 +1100 (EST)
Date: Tue, 4 Jan 2011 16:26:55 -0500
From: Sean MacLennan <seanm@seanm.ca>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Question about combining a PCI driver with an OF driver
Message-ID: <20110104162655.3fa2dba0@lappy.seanm.ca>
In-Reply-To: <OF2F9BC586.7E8383F3-ON8825780E.0072ACEA-8825780E.00735E90@selinc.com>
References: <OF413F3FA8.B1C9F99A-ON8825780E.006706F6-8825780E.00683E0B@selinc.com>
	<20110104132317.006ead39@udp111988uds.am.freescale.net>
	<OF2F9BC586.7E8383F3-ON8825780E.0072ACEA-8825780E.00735E90@selinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 4 Jan 2011 13:00:07 -0800
Bruce_Leonard@selinc.com wrote:

> True, but we really didn't want to recreate all the infrastructure
> that the gianfar driver has in it we wanted to just use it.  Maybe
> what I should do is just take the guts of the gianfar driver and make
> a pure PCI driver out of it. 

This is what I would do. Odds are the final FPGA driver will have a lot
of "optimizations" and "we don't need this" changes to the point where
you won't be able to read the original code for ifdefs ;)

Cheers,
   Sean
