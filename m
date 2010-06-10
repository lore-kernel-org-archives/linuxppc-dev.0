Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id C2D99B7D43
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Jun 2010 19:22:03 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH v21 011/100] eclone (11/11): Document sys_eclone
Date: Thu, 10 Jun 2010 11:15:50 +0200
References: <AANLkTimDfbJkAuoK1-asvk8Ub9C9QBkK5RkzLR3ilJUY@mail.gmail.com>
	<AANLkTinFGblE4fW35O0LchJZ22tz_5-qervpGC_lpUj_@mail.gmail.com>
	<20100609181431.GB1211@us.ibm.com>
In-Reply-To: <20100609181431.GB1211@us.ibm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201006101115.51073.arnd@arndb.de>
Cc: randy.dunlap@oracle.com, Albert Cahalan <acahalan@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, hpa@zytor.com,
	linuxppc-dev@lists.ozlabs.org, roland@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 09 June 2010, Sukadev Bhattiprolu wrote:
> Albert and Randy point out that this would require #ifdefs in the
> application code that intends to be portable across say IA64 and x86.
> 
> Can we instead have all architectures specify [base, size] ?

No objections from me on that.

	Arnd
