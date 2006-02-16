Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6DC39679EF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Feb 2006 15:49:51 +1100 (EST)
Date: Wed, 15 Feb 2006 20:49:48 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: ????????? <lonsn@163.com>
Subject: Re: Re: Gigabit ethernet support of ppc440gx in 2.6 and 2.4
Message-ID: <20060216044948.GA23150@gate.ebshome.net>
References: <43F402AC.026BD0.10674>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43F402AC.026BD0.10674>
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

On Thu, Feb 16, 2006 at 12:45:15PM +0800, ????????? wrote:
> Does the TCP/IP Acceleration Hardware of 440GX have been supported 
> in official 2.6 kernel?
> How about the CPU utilization when you get 900+Mb/s? Since we want 
> to do something such as simple datas codec at the same time.

My driver (both 2.4 and 2.6) supports TCP/UDP checksum offload. No TSO 
yet.

I don't remember exact CPU load numbers, but it was less than 20% for 
TX case (Ocotea was transmitting data).

-- 
Eugene
