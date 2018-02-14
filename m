Return-Path: <dan.carpenter@oracle.com>
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zh9z81dnCzF0xb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 18:29:55 +1100 (AEDT)
Date: Wed, 14 Feb 2018 10:29:41 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [bug report] ocxl: Add AFU interrupt support
Message-ID: <20180214072941.6wbrcsw4dqdilcrn@mwanda>
References: <20180213081234.GA19567@mwanda>
 <dc0b4b1c-b3f5-bc4e-1f96-96055fecd77d@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dc0b4b1c-b3f5-bc4e-1f96-96055fecd77d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 13, 2018 at 08:29:26PM +0100, Frederic Barrat wrote:
> Hi,
> 
> Thanks for the report. I'll fix the first issue. The 2nd is already on its
> way to upstream:
> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?id=dedab7f0d3137441a97fe7cf9b9ca5
> 
> (though we still have a useless cast in there; will fix as well).
> 
> May I ask what static checker you're using?
> 

These are Smatch warnings.

regards,
dan carpenter
