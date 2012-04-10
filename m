Return-Path: <key@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0E65AB700F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2012 04:53:30 +1000 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <key@linux.vnet.ibm.com>;
 Tue, 10 Apr 2012 12:53:28 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 8263F3E40049
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2012 12:52:43 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q3AIqMeK181242
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2012 12:52:23 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q3AIqoGB022982
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2012 12:52:51 -0600
Message-ID: <1334084007.16827.38.camel@key-ThinkPad-W510>
Subject: Re: [PATCH v2 14/17] powerpc: crypto: nx driver code supporting nx
 encryption
From: Kent Yoder <key@linux.vnet.ibm.com>
To: David Miller <davem@davemloft.net>
Date: Tue, 10 Apr 2012 13:53:27 -0500
In-Reply-To: <20120410.144136.1777978593334560368.davem@davemloft.net>
References: <1334070249.16827.1.camel@key-ThinkPad-W510>
 <1334070657.16827.29.camel@key-ThinkPad-W510>
 <20120410.144136.1777978593334560368.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: rcj@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Dave,

On Tue, 2012-04-10 at 14:41 -0400, David Miller wrote:
> From: Kent Yoder <key@linux.vnet.ibm.com>
> Date: Tue, 10 Apr 2012 10:10:57 -0500
> 
> > These routines add the base device driver code supporting the Power7+
> > in-Nest encryption accelerator (nx) device.
> > 
> > Signed-off-by: Kent Yoder <key@linux.vnet.ibm.com>
> 
> This patch should be earlier in the series, so it can
> appear before the drivers which use the helper routines
> in here.

  I wasn't sure which order to post these in since the structures I
register with the crypto api in this patch live in the earlier .c files,
so there's a circular dependency.  I can reorder if you want though.

Kent

> 
