Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y6b5p4KXXzDqqQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 23:37:50 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rob Herring <robh@kernel.org>
Cc: "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, David Laight <David.Laight@aculab.com>,
 "nfont\@linux.vnet.ibm.com" <nfont@linux.vnet.ibm.com>,
 "tyreld\@linux.vnet.ibm.com" <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 4/5] powerpc: pseries: only store the device node
 basename in full_name
In-Reply-To: <CAL_JsqLiTFM=THW0+WXXUY3S-T4QamV8vS5pWZBPm0oOybQLgg@mail.gmail.com>
References: <20170821151651.25096-1-robh@kernel.org>
 <20170821151651.25096-5-robh@kernel.org>
 <87tvzgd1l3.fsf@concordia.ellerman.id.au>
 <CAL_JsqLiTFM=THW0+WXXUY3S-T4QamV8vS5pWZBPm0oOybQLgg@mail.gmail.com>
Date: Wed, 04 Oct 2017 23:37:49 +1100
Message-ID: <87infvozqa.fsf@concordia.ellerman.id.au>
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

Rob Herring <robh@kernel.org> writes:
> On Tue, Oct 3, 2017 at 4:26 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
...
>>
>> The obvious fix is just to allocate it separately as before, eg ~=:
>
> Yes, I'll go back to doing 2 allocs like v1, but using kstrdup as was
> also pointed out.

Yeah that would be better still I guess.

cheers
