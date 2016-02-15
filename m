Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F358B1A033D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 22:16:18 +1100 (AEDT)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 15 Feb 2016 04:16:16 -0700
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id D3BC91FF0025
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 04:04:22 -0700 (MST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1FBGCAY28246092
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 11:16:12 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1FBGCO5024005
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 06:16:12 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: gwshan@linux.vnet.ibm.com
Subject: Re: Rebase of my fixes branch
In-Reply-To: <1455532680.26205.8.camel@ellerman.id.au>
References: <1455532680.26205.8.camel@ellerman.id.au>
Date: Mon, 15 Feb 2016 16:46:07 +0530
Message-ID: <87a8n2fclk.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> Hi folks,
>
> FYI I've rebased my fixes branch.
>
> Unfortunately we had a couple of fixes in fixes that needed fixes in order to
> be actual fixes.
>
> So if you're basing some work on it you'll have to fetch and rebase.
>
> The old head commit was: 0fe53e8d335bfc02f81300b70211e61fb931a725
>            and now it's: c777e2a8b65420b31dac28a453e35be984f5808b
>

Did we miss this ?

http://mid.gmane.org/20160131083738.AA047140C40@ozlabs.org

-aneesh
