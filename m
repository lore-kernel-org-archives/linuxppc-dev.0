Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x230.google.com (mail-pg0-x230.google.com
 [IPv6:2607:f8b0:400e:c05::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ySphD0t7dzDqwS
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Nov 2017 15:22:19 +1100 (AEDT)
Received: by mail-pg0-x230.google.com with SMTP id j3so1487072pga.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Nov 2017 21:22:19 -0700 (PDT)
Date: Fri, 3 Nov 2017 15:22:08 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] powerpc/64s: idle skip POWER9 DD1 and DD2.0
 specific workarounds on DD2.1
Message-ID: <20171103152208.75b4113b@roar.ozlabs.ibm.com>
In-Reply-To: <1509671599.16627.53.camel@neuling.org>
References: <20171102015535.30843-1-npiggin@gmail.com>
 <20171102015535.30843-3-npiggin@gmail.com>
 <1509671599.16627.53.camel@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 03 Nov 2017 12:13:19 +1100
Michael Neuling <mikey@neuling.org> wrote:

> On Thu, 2017-11-02 at 12:55 +1100, Nicholas Piggin wrote:
> > DD2.1 does not have to flush the ERAT after a state-loss idle. It also
> > does not have to save and restore MMCR0 (although it does have to save
> > restore in deep idle states, like other PMU registers).  
> 
> Minor nit, can we do this as two separate commits in case we discover one is
> broken.

Good idea, resent.

Thanks,
Nick
