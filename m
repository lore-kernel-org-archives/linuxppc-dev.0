Return-Path: <xenidis@gmail.com>
Received: from mail-gg0-f179.google.com (mail-gg0-f179.google.com
 [209.85.161.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DE1552C00D2
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Dec 2012 00:12:39 +1100 (EST)
Received: by mail-gg0-f179.google.com with SMTP id q1so68360gge.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Dec 2012 05:12:36 -0800 (PST)
Sender: Jimi Xenidis <xenidis@gmail.com>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: Re: [RFC] Add IBM Blue Gene/Q Platform
From: Jimi Xenidis <jimix@pobox.com>
In-Reply-To: <22146.1354858896@neuling.org>
Date: Fri, 7 Dec 2012 07:12:31 -0600
Message-Id: <17203923-C5C4-4659-9F3C-786D20C5C62E@pobox.com>
References: <958841B4-9626-48A2-A28A-13EA3F1D52AE@pobox.com>
 <22146.1354858896@neuling.org>
To: Michael Neuling <mikey@neuling.org>
Cc: Andrew T Tauferner <ataufer@us.ibm.com>, Kumar Gala <kumar.gala@gmail.com>,
 Jay Bryant <jsbryant@us.ibm.com>, Todd Inglett <tinglett@us.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 6, 2012, at 11:41 PM, Michael Neuling <mikey@neuling.org> wrote:

>> commit f6e3c1f706cb6922349d639a74ff6c50acc8b9f8
>> Author: Jimi Xenidis <jimix@pobox.com>
>> Date:   Wed Dec 5 13:41:25 2012 -0500
>>=20
>>    powerpc: Remove unecessary VSX symbols
>>=20
>>    The symbol THREAD_VSR0 is defined to be the same as THREAD_FPR0.  =
Its
>>    presence causes build issues with more complex configurations.
>>=20
>>    Signed-off-by: Jimi Xenidis <jimix@pobox.com>
>>=20
>=20
> Can you explain what these "complex configurations" are?

In an earlier email we discussed the possibility that there was the =
possibility/desire that a single binary could support either FPU, VSX =
and the new QPX.
However, if a CONFIG_VSX is not defined then THREAD_VSR0 does not get =
defined even though there might be some code that refers to it.
Since it is an alias for the same piece of storage I was hoping to solve =
my config issue and be simplify the code.

-jx


>=20
> Mikey
