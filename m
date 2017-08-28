Return-Path: <dan.carpenter@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xglVr4PCnzDqGW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 18:36:52 +1000 (AEST)
Date: Mon, 28 Aug 2017 11:36:19 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Matthias Fuchs <matthias.fuchs@esd-electronics.com>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] powerpc/44x: mask and shift to zero bug
Message-ID: <20170828083618.pbbelpkp6smk4bza@mwanda>
References: <20170825103340.op3uphrv3eyeutiz@mwanda>
 <1503809791.3814.43.camel@kernel.crashing.org>
 <20170828075705.dxyoqyxgmd3ila3g@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170828075705.dxyoqyxgmd3ila3g@mwanda>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 28, 2017 at 10:57:05AM +0300, Dan Carpenter wrote:
> I sent this email during kernel summit and neither of us could send a
> patch at the time and we both problem forgot.  I definitely forgot.
> 

s/problem/probably/... I suck at email.  :(

regards,
dan carpenter
