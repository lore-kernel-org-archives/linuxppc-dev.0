Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 09D361A0018
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 18:29:53 +1100 (AEDT)
Received: by mail-pa0-x230.google.com with SMTP id yy13so6622062pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 23:29:52 -0800 (PST)
Subject: Re: [RFC, kernel] powerpc/ioda: Set "read" permission when "write" is
 set
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <20160216031824.E5C8E140761@ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <56C42146.5080608@ozlabs.ru>
Date: Wed, 17 Feb 2016 18:29:10 +1100
MIME-Version: 1.0
In-Reply-To: <20160216031824.E5C8E140761@ozlabs.org>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/16/2016 02:18 PM, Michael Ellerman wrote:
> On Tue, 2016-12-01 at 04:40:20 UTC, Alexey Kardashevskiy wrote:
>> Quite often drivers set only "write" permission assuming that this
>> includes "read" permission as well and this works on plenty platforms.
>> However IODA2 is strict about this and produces an EEH when "read"
>> permission is not and reading happens.
>>
>> This adds a workaround in IODA code to always add the "read" bit when
>> the "write" bit is set.
>>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> Tested-by: Douglas Miller <dougmill@linux.vnet.ibm.com>
>
> Are you planning on sending a non-RFC version of this?

Just posted.

> If so is it an urgent fix I should send upstream now?

Yes.

 > And if so should it also be CC'ed to stable?

Ben suggested that yes, it should. Thanks. Sorry about breaking things.


-- 
Alexey
