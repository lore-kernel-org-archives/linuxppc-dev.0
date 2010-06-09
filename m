Return-Path: <hpa@zytor.com>
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8BB42B7D5C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Jun 2010 05:09:47 +1000 (EST)
Message-ID: <4C0FE17B.10108@zytor.com>
Date: Wed, 09 Jun 2010 11:46:19 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH v21 011/100] eclone (11/11): Document sys_eclone
References: <AANLkTimDfbJkAuoK1-asvk8Ub9C9QBkK5RkzLR3ilJUY@mail.gmail.com>
	<20100601193230.GA17579@us.ibm.com>
	<AANLkTinxCKl7RVe62UhIpNe5EriCufkgaih2D2mLLmC4@mail.gmail.com>
	<20100602013839.GB17579@us.ibm.com>
	<AANLkTinFGblE4fW35O0LchJZ22tz_5-qervpGC_lpUj_@mail.gmail.com>
	<20100609181431.GB1211@us.ibm.com>
In-Reply-To: <20100609181431.GB1211@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: randy.dunlap@oracle.com, arnd@arndb.de, Albert Cahalan <acahalan@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@lists.ozlabs.org, roland@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/09/2010 11:14 AM, Sukadev Bhattiprolu wrote:
> | 
> | Even for x86, it's an easier API. Callers would be specifying
> | two numbers they already have: the argument and return value
> | for malloc. Currently the numbers must be added together,
> | destroying information, except on hppa (must not add size)
> | and ia64 (must use what I'm proposing already).
> 
> I agree its easier and would avoid #ifdefs in the applications.
> 
> Peter, Arnd, Roland - do you have any concerns with requiring all
> architectures to specify the stack to eclone() as [base, offset]
> 

Makes sense to me.  There might be advantages to be able to track the
size of the "stack allocation" even for other architectures, too.

	-hpa
