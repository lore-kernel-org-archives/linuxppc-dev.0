Return-Path: <swise@opengridcomputing.com>
Received: from smtp.opengridcomputing.com (smtp.opengridcomputing.com
	[209.198.142.2]) by ozlabs.org (Postfix) with ESMTP id 6DA4CB6FFC
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Mar 2011 07:51:37 +1100 (EST)
Message-ID: <4D7E7FCE.3000703@opengridcomputing.com>
Date: Mon, 14 Mar 2011 15:51:26 -0500
From: Steve Wise <swise@opengridcomputing.com>
MIME-Version: 1.0
To: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [PATCH] cxgb4: use pgprot_writecombine() on powerpc
References: <1300134971-16752-1-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1300134971-16752-1-git-send-email-nacc@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/14/2011 03:36 PM, Nishanth Aravamudan wrote:
> Commit fe3cc0d99de6a9bf99b6c279a8afb5833888c1f7 ("powerpc: Add
> pgprot_writecombine") in benh's tree exposes the pgprot_writecombine()
> API to drivers on powerpc. cxgb4 has an open-coded version of the same,
> so use the common API now that it's available.
>
> Signed-off-by: Nishanth Aravamudan<nacc@us.ibm.com>
> Cc: Steve Wise<swise@opengridcomputing.com>
> Cc: Anton Blanchard<anton@samba.org>
>
> ---
>
> Given that this depends on a patch in Ben's tree, should this go in via
> the powerpc tree? Presuming Steve acks it, of course.
>
>   drivers/infiniband/hw/cxgb4/t4.h |    5 +----
>   1 files changed, 1 insertions(+), 4 deletions(-)
>

Acked-by: Steve Wise <swise@opengridcomputing.com>

I suppose it should go into the same tree with the commit that adds this function.


Steve.
