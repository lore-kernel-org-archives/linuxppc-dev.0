Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 26D60B7B9C
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2009 07:27:21 +1100 (EST)
Subject: Re: e500 lowmem & TLBs
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <bc81dc640910210852l7c6d3f11ia0fb5524f952fe9d@mail.gmail.com>
Date: Wed, 21 Oct 2009 15:27:13 -0500
Message-Id: <2099631E-2454-4816-838D-D82145A3B05B@kernel.crashing.org>
References: <bc81dc640910210852l7c6d3f11ia0fb5524f952fe9d@mail.gmail.com>
To: Aaron Pace <kodiakuppercut@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 21, 2009, at 10:52 AM, Aaron Pace wrote:

> Hello,
>
> For the e500 processors, it appears that the first 3 of 16 permanent
> TLB entries are used to map lowmem.   Are the other 13 ever used?
>
not right now.  We intend to use them for hugetlbfs support.

- k
