Return-Path: <htejun@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by ozlabs.org (Postfix) with ESMTP id E6E5FDDF0A
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 16:30:51 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so6002588pyg.27
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 23:30:50 -0700 (PDT)
Message-ID: <4816C094.6030601@gmail.com>
Date: Tue, 29 Apr 2008 15:30:44 +0900
From: Tejun Heo <htejun@gmail.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] devres: support addresses greater than an unsigned long
	via dev_ioremap
References: <Pine.LNX.4.64.0804290122210.10928@blarg.am.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0804290122210.10928@blarg.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org, jgarzik@pobox.com,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> Use a resource_size_t instead of unsigned long since some arch's are
> capable of having ioremap deal with addresses greater than the size of a
> unsigned long.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Acked-by: Tejun Heo <htejun@gmail.com>

Thanks.

-- 
tejun
