Return-Path: <tomof@acm.org>
Received: from mo11.iij4u.or.jp (mo11.iij4u.or.jp [210.138.174.79])
	by ozlabs.org (Postfix) with ESMTP id 17806DDECF
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jan 2008 03:43:59 +1100 (EST)
Date: Tue, 1 Jan 2008 01:11:33 +0900
To: balbir@linux.vnet.ibm.com, akpm@linux-foundation.org
Subject: Re: SCSI errors on powerpc with 2.6.24-rc6-mm1
From: FUJITA Tomonori <tomof@acm.org>
In-Reply-To: <4778E037.6000001@linux.vnet.ibm.com>
References: <4774A74B.3000105@linux.vnet.ibm.com>
	<20071228165115O.tomof@acm.org>
	<4778E037.6000001@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20080101011452P.tomof@acm.org>
Cc: fujita.tomonori@lab.ntt.co.jp, linuxppc-dev@ozlabs.org, tomof@acm.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 31 Dec 2007 17:57:35 +0530
Balbir Singh <balbir@linux.vnet.ibm.com> wrote:

> FUJITA Tomonori wrote:
> > 
> > Oops, it's for -mm.
> > 
> 
> Hi,
> 
> I just tested this patch and it works fine for me so far.
> 
> Tested-by: Balbir Singh <balbir@linux.vnet.ibm.com>

Thanks!

I sent an updated patch including this fix several hours ago:

http://ozlabs.org/pipermail/linuxppc-dev/2007-December/048997.html
