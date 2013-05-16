Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by ozlabs.org (Postfix) with ESMTP id 1BCA12C014A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 May 2013 00:56:30 +1000 (EST)
Received: from mail-vb0-f50.google.com (mail-vb0-f50.google.com
 [209.85.212.50])
 by muin.pair.com (Postfix) with ESMTPSA id 414418FC3F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 10:56:27 -0400 (EDT)
Received: by mail-vb0-f50.google.com with SMTP id w15so334629vbb.37
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 07:56:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1368687133.9603.51.camel@pasglop>
References: <1368679657.9603.32.camel@pasglop>
 <1368683156.9603.34.camel@pasglop>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0701C307@039-SN2MPN1-012.039d.mgd.msft.net>
 <3E027F8168735B46AC006B1D0C7BB0020B1E040F@039-SN2MPN1-011.039d.mgd.msft.net>
 <1368684547.9603.38.camel@pasglop> <51947A00.9010504@windriver.com>
 <1368685307.9603.39.camel@pasglop> <51947E35.30808@windriver.com>
 <1368686426.9603.49.camel@pasglop> <5194800D.3010606@windriver.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0701C498@039-SN2MPN1-012.039d.mgd.msft.net>
 <1368687133.9603.51.camel@pasglop>
Date: Thu, 16 May 2013 09:56:26 -0500
Message-ID: <CAOZdJXU79kqEGk_nqv1NSzna7c=bgwSv+6WFgaTVjR4Rj4cZVg@mail.gmail.com>
Subject: Re: SATA FSL and upstreaming
From: Timur Tabi <timur@tabi.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Xie Shaohui-B21989 <B21989@freescale.com>,
 Liu Qiang-B32616 <B32616@freescale.com>,
 Zang Roy-R61911 <r61911@freescale.com>,
 "tiejun.chen" <tiejun.chen@windriver.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 Bhushan Bharat-R65777 <R65777@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 16, 2013 at 1:52 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>> 3) run " pix altbak" command
>>
>> 4) check you are on bank4
>
> It stays on bank 0

pix altbank
