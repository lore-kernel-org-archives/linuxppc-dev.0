Return-Path: <linas@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 02CA467B56
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 05:31:24 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7BJVEsi008445
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 15:31:19 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k7BJV3u2202138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 13:31:03 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7BJV3eL015262
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 13:31:03 -0600
Date: Fri, 11 Aug 2006 14:31:02 -0500
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 0/4]:  powerpc/cell spidernet ethernet driver fixes
Message-ID: <20060811193102.GN10638@austin.ibm.com>
References: <20060811170337.GH10638@austin.ibm.com>
	<20060811174439.GA30191@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060811174439.GA30191@mars.ravnborg.org>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
	James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 11, 2006 at 07:44:39PM +0200, Sam Ravnborg wrote:
> > 
> > These have been well-tested over the last few weeks. Please apply. 
> Hi Linas.
> Just noticed a nit-pick detail.
> The general rule is to add your Signed-off-by: at the bottom of the
> patch, so the top-most Signed-of-by: is also the original author whereas
> the last Signed-of-by: is the one that added this patch to the kernel.

I put my name at the top when I was the primary author. 
I put Jim's name at the top when he was the primary author. 

Both names are there because I sat in Jim's office and used
his keyboard. I got him to compile and run the tests on
his hardware, and we'd then debate the results.

> Likewise you add Cc: before your Signed-off-by: line.

The patches I ave from akpm have the CC's after the 
signed-off by line, not before.

--linas
