Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 497592C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 May 2013 15:02:09 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Wed, 1 May 2013 10:26:10 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 5DA1AE004A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 May 2013 10:34:10 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4151pWA10223976
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 May 2013 10:31:52 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4151vNo015856
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 May 2013 05:01:58 GMT
Message-ID: <5180A1AD.4060409@linux.vnet.ibm.com>
Date: Wed, 01 May 2013 10:31:33 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the vfs tree with the powerpc tree
References: <20130501120636.0e54681b2dfb7ebe6aeb27c4@canb.auug.org.au>
In-Reply-To: <20130501120636.0e54681b2dfb7ebe6aeb27c4@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
 linux-next@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/01/2013 07:36 AM, Stephen Rothwell wrote:
> Hi Al,
>
> Today's linux-next merge of the vfs tree got a conflict in
> arch/powerpc/kernel/rtas_flash.c between commit fb4696c39573
> ("powerpc/rtas_flash: Fix bad memory access") from the powerpc tree and
> commits ad18a364f186 ("powerpc/rtas_flash: Free kmem upon module exit")
> and 2352ad01409d ("ppc: Clean up rtas_flash driver somewhat") from the
> vfs tree.
>

Stephen,

As Ben mentioned earlier, there are outstanding comments from me which
needs to be addressed by Dave, before its merged.


-Vasant

> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).
>
