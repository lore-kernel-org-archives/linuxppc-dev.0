Return-Path: <consul.kautuk@gmail.com>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
 [209.85.213.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6220CB6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2012 14:27:08 +1100 (EST)
Received: by yenl1 with SMTP id l1so701037yen.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2012 20:27:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1332278973.2982.24.camel@pasglop>
References: <1332259260-1943-1-git-send-email-consul.kautuk@gmail.com>
 <1332278936.2982.23.camel@pasglop>
 <1332278973.2982.24.camel@pasglop>
Date: Wed, 21 Mar 2012 08:57:05 +0530
Message-ID: <CAFPAmTQtDnQ-jrc-hqtTshciqnx-iS5wSwCiCN11ZWJUOc-cfg@mail.gmail.com>
Subject: Re: [PATCH 04/20 v3] powerpc/mm/fault.c: Port OOM changes to
 do_page_fault
From: Kautuk Consul <consul.kautuk@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org,
 Christian Dietrich <christian.dietrich@informatik.uni-erlangen.de>,
 Paul Mackerras <paulus@samba.org>, "Mohd. Faris" <mohdfarisq2010@gmail.com>,
 Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>
>> I have done that port already :-) It's in powerpc-next which I will send
>> to Linus to pull today or tomorrow....

Oops, sorry I didn't know that as I don't regularly follow the powerpc tree.
I just did this change for all architectures. :)

>
> BTW. Feel free to review what I've done, it's quite possible that I have
> screwed something up ...

Okay, I'll take a look at it. Thanks again. :)

>
> Cheers,
> Ben.
