Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F66A1A0D03
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jul 2015 08:31:04 +1000 (AEST)
Date: Thu, 2 Jul 2015 08:31:03 +1000
From: Anton Blanchard <anton@samba.org>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 linux-kernel@vger.kernel.org, bharata@linux.vnet.ibm.com
Subject: Re: [RFC PATCH] powerpc/numa: initialize distance lookup table from
 drconf path
Message-ID: <20150702083103.61151467@kryten>
In-Reply-To: <87d20mewk2.fsf@linux.vnet.ibm.com>
References: <1433911816-854-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <87lhfs5ewc.fsf@linux.vnet.ibm.com>
 <20150623111648.1e31a497@kryten>
 <87d20mewk2.fsf@linux.vnet.ibm.com>
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

Hi Nikunj,

> > Thanks for the patch. Have we tested that this doesn't regress the
> > non dynamic representation?
> 
> Yes, that is tested. And works as expected.

Great, you can add:

Acked-by: Anton Blanchard <anton@samba.org>

Anton
