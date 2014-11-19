Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0F8971A09D1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 18:09:19 +1100 (AEDT)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Wed, 19 Nov 2014 00:09:17 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 8A08E3E40030
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 00:09:15 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAJ79EQ553215276
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 08:09:14 +0100
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAJ79EdV008619
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 00:09:14 -0700
Message-ID: <546C420B.30307@linux.vnet.ibm.com>
Date: Wed, 19 Nov 2014 12:38:59 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] cpuidle/powernv: Re-enable fastsleep at boot time
References: <20141118065603.22544.88816.stgit@preeti.in.ibm.com>
 <CACPK8Xc7G6JgqPYUmGTx8O=a6jxMB0yf1weEraMBu8dcAJibuQ@mail.gmail.com>
In-Reply-To: <CACPK8Xc7G6JgqPYUmGTx8O=a6jxMB0yf1weEraMBu8dcAJibuQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, rjw@rjwysocki.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Joel,

On 11/19/2014 08:04 AM, Joel Stanley wrote:
> Hey Preeti,
> 
> On Tue, Nov 18, 2014 at 5:26 PM, Preeti U Murthy
> <preeti@linux.vnet.ibm.com> wrote:
>> Commit dcb18694 "Fix ipi on palmeto" disabled fastsleep at boot time.
> 
> I couldn't find this commit in any tree; upstream, mpe's next, nor powerkvm.

Oh yes you are right. I must have been looking at the wrong git branch.
I verified upstream now. The commit dcb18694 is not present.So we are
good. Thanks for pointing this out :)

Sorry for the noise!
> 
> I remember testing this as a workaround for the palmetto, but I don't
> recall sending it upstream.
> 
> Cheers,
> 
> Joel
> 

Regards
Preeti U Murthy
