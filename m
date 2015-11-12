Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C6A11A0311
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2015 13:26:21 +1100 (AEDT)
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AF3B514076B
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2015 13:26:20 +1100 (AEDT)
Received: by pasz6 with SMTP id z6so50629109pas.2
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2015 18:26:19 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org, imunsie@au1.ibm.com
Subject: Re: [PATCH] cxl: use correct operator when writing pcie config space
 values
In-Reply-To: <56404105.1010302@au1.ibm.com>
References: <1446603849-26796-1-git-send-email-andrew.donnellan@au1.ibm.com>
 <87oaf8hwt2.fsf@gamma.ozlabs.ibm.com>
 <1446767022.25265.2.camel@ellerman.id.au> <56404105.1010302@au1.ibm.com>
Date: Thu, 12 Nov 2015 13:26:14 +1100
Message-ID: <8737wcymux.fsf@gamma.ozlabs.ibm.com>
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

Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:

> On 06/11/15 10:43, Michael Ellerman wrote:
>> If it's unused *and* broken then we should just remove it.
>
> Following some discussion with Ian and Vaibhav, we'd like to keep it at 
> this stage - while there are no current AFUs which write to AFU config 
> space, it would be reasonable for an AFU developer to assume that AFU 
> config space is writable, and I am led to believe there is nothing in 
> the publicly available documentation that would suggest otherwise.
>
> Ian is working on obtaining a test AFU with support for this, at which 
> point we will add it to our internal test suite.
>
> As such I'd like to continue with the patch as is, I'm happy to drop the 
> stable Cc though.

Sounds good to me.

Regards,
Daniel

>
>
> Andrew
>
> -- 
> Andrew Donnellan              Software Engineer, OzLabs
> andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
> +61 2 6201 8874 (work)        IBM Australia Limited
