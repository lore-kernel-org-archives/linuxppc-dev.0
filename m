Return-Path: <xerofoify@gmail.com>
Received: from mail-ve0-x22d.google.com (mail-ve0-x22d.google.com
 [IPv6:2607:f8b0:400c:c01::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7DE791A0010
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jul 2014 13:09:33 +1000 (EST)
Received: by mail-ve0-f173.google.com with SMTP id db11so5048908veb.32
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Jul 2014 20:09:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1404788634.16156.38.camel@pasglop>
References: <CAPDOMVi5ptjaKzT+Exd3XtKcy7W7nNZYUD+MEwN8LmhPrQTZBQ@mail.gmail.com>
 <1404788634.16156.38.camel@pasglop>
Date: Mon, 7 Jul 2014 23:09:29 -0400
Message-ID: <CAPDOMVi8kcCZf1gSvBLWq4+X3ZnrZXcwPstzafM4K_Re4eiKRQ@mail.gmail.com>
Subject: Re: Allyesconfig for powerpc still Failing
From: Nick Krause <xerofoify@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: mahesh <mahesh@linux.vnet.ibm.com>, agraf <agraf@suse.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 michael <michael@ellerman.id.au>, paulus@samba.org, anton <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Just hoped this log may help you in your issues with the train wreck.
If you need any help with the issues here please let me know.
Cheers Nick :)

On Mon, Jul 7, 2014 at 11:03 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Mon, 2014-07-07 at 22:45 -0400, Nick Krause wrote:
>> Today I tested the allyesconfig for powerpc and it seems to be still
>> failing according to my tests.
>> Below are the error messages I get before the jobs finish and exit
>> failing the build.
>> Cheers Nick
>> arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
>> arch/powerpc/kernel/exceptions-64s.S:1331: Error: attempt to move .org backwards
>> make[1]: *** [arch/powerpc/kernel/head_64.o] Error 1
>> make: *** [arch/powerpc/kernel] Error 2
>> make: *** Waiting for unfinished jobs....
>
> Yes, it's a trainwreck and I don't know how to fix it yet ... I tried
> various more or less invasive approaches and none of them worked
> properly so far. I need to spend more time on this.
>
> Cheers,
> Ben.
>
>
