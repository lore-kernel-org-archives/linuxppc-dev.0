Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zpCKw1lq9zF1cb
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Feb 2018 13:52:04 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, npiggin@gmail.com, linuxppc-dev@ozlabs.org,
 linux@roeck-us.net, corsac@debian.org
Subject: Re: [PATCH v4.4 backport 2/3] powerpc/64s: Simple RFI macro
 conversions
In-Reply-To: <20180223125805.GA23233@kroah.com>
References: <20180222065738.GB2428@kroah.com>
 <20180222123545.8946-1-mpe@ellerman.id.au>
 <20180222123545.8946-2-mpe@ellerman.id.au>
 <87606nq527.fsf@concordia.ellerman.id.au> <20180223125805.GA23233@kroah.com>
Date: Sat, 24 Feb 2018 13:51:59 +1100
Message-ID: <87vaen9k1c.fsf@concordia.ellerman.id.au>
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

Greg KH <greg@kroah.com> writes:

> On Fri, Feb 23, 2018 at 11:11:12PM +1100, Michael Ellerman wrote:
>> Michael Ellerman <mpe@ellerman.id.au> writes:
>> > Subject: [PATCH v4.4 backport 2/3] powerpc/64s: Simple RFI macro conversions
>>                      ^
>>                    4.9
>> 
>> Gah, sorry just realised these last two have "v4.4" in the subject, but
>> it should be "4.9".
>
> Ah, good, I was wondering about that :)

Sorry for the confusion, I need to automate generation of the patch
subjects obviously :)

> I'll apply these after lunch...

Thanks.

cheers
