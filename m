Return-Path: <jwboyer@gmail.com>
Received: from mail-oa0-x22c.google.com (mail-oa0-x22c.google.com
 [IPv6:2607:f8b0:4003:c02::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3B1832C0145
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 09:49:57 +1000 (EST)
Received: by mail-oa0-f44.google.com with SMTP id l20so7069119oag.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 16:49:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1376956039.25016.103.camel@pasglop>
References: <20130808224501.GA8925@home.buserror.net>
 <1376453881.4255.57.camel@pasglop>
 <1376499759.31636.15.camel@snotra.buserror.net>
 <1376514060.4255.73.camel@pasglop>
 <1376952992.31636.382.camel@snotra.buserror.net>
 <1376956039.25016.103.camel@pasglop>
Date: Mon, 19 Aug 2013 19:49:54 -0400
Message-ID: <CA+5PVA49T3gWCb-tt83iabNPwB7=xA8qLw3CY06z4mpZHjj7OA@mail.gmail.com>
Subject: Re: Pull request: scottwood/linux.git next
From: Josh Boyer <jwboyer@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 19, 2013 at 7:47 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Mon, 2013-08-19 at 17:56 -0500, Scott Wood wrote:
>> If we use the generic CPU target then mftb won't get turned into mfspr
>> (I assume this is what you meant by "tricky asm").  Does mfspr work
>> everywhere, including from userspace?  Or do we need to patch?  What
>> about 403GCX which seems to need some special SPR (I could leave the
>> existing ifdef alone, but what about vdso)?
>
> I think mfspr works everywhere we care about but I might be mistaken :-)
> I don't think anybody have tried booting a 403 in a looooong time. I
> would be surprised if it still worked.

I think I have one buried somewhere in my garage.  I'm not digging it out.

josh
