Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 006A81A0A00
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Feb 2015 17:00:29 +1100 (AEDT)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 11 Feb 2015 23:00:27 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 7B36819D803F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 22:51:34 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1C5woR819333172
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 22:58:58 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1C5xmhs013221
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 22:59:49 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Vipin K Parashar <vipin@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V4] powerpc, powernv: Add OPAL platform event driver
In-Reply-To: <54DC3E7A.3090404@linux.vnet.ibm.com>
References: <1423206522-18084-1-git-send-email-vipin@linux.vnet.ibm.com>
 <m31tlxniqp.fsf@oc8180480414.ibm.com> <54DC3E7A.3090404@linux.vnet.ibm.com>
Date: Thu, 12 Feb 2015 16:59:29 +1100
Message-ID: <m3wq3nllfi.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joel Stanley <joel@jms.id.au>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vipin K Parashar <vipin@linux.vnet.ibm.com> writes:
>> - What do UPSs do? It would seem that some common "this is what's about
>>    to happen to your power" would almost *have* to exist somewhat
>>    generically?
> UPS class tells about UPS status with system. FSP sends mbox messages 
> with UPS status along with
> UPS status bit which tells exactly as to what change is there in UPS 
> status like UPS installed, UPS battery low, UPS removed (By passed). We 
> plan to add support for these UPS events in skiboot to provide more
> UPS details.

I was thinking of UPSs on systems other than IBM FSP based POWER
systems.... like if I went down the street and bought one for $100 and
plugged it into my x86 desktop.
