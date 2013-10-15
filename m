Return-Path: <mohicks@gmail.com>
Received: from mail-ie0-x22c.google.com (mail-ie0-x22c.google.com
 [IPv6:2607:f8b0:4001:c03::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9665E2C0344
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Oct 2013 05:44:50 +1100 (EST)
Received: by mail-ie0-f172.google.com with SMTP id tp5so1464055ieb.17
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Oct 2013 11:44:46 -0700 (PDT)
MIME-Version: 1.0
Sender: mohicks@gmail.com
In-Reply-To: <1381851009.17841.14.camel@pasglop>
References: <CAJUS3Xn4tHKvDK8tzLw09+zsEAJHEScV2DbZhH9KkYL-5iCmUA@mail.gmail.com>
 <CAJUS3X=LVHDMa+CTFS=O=F=DfU1=0cgcNzn-mEvXGaDXEZ+CBA@mail.gmail.com>
 <1381851009.17841.14.camel@pasglop>
Date: Tue, 15 Oct 2013 14:44:46 -0400
Message-ID: <CAJUS3XmN2WNJ1cnorb5vfas7mB6tdNLxuupFja=u_wYS=cxmdQ@mail.gmail.com>
Subject: Re: Perf not resolving all symbols, showing 0x7ffffxxx
From: Martin Hicks <mort@bork.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 15, 2013 at 11:30 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2013-10-15 at 09:59 -0400, Martin Hicks wrote:
>> I've tracked the start of the strange instruction pointers in 'perf
>> report' to a commit by Anton:
>>
>> commit 75382aa72f06823db7312ad069c3bae2eb3f8548
>> Author: Anton Blanchard <anton@samba.org>
>> Date:   Tue Jun 26 01:01:36 2012 +0000
>>
>>     powerpc/perf: Move code to select SIAR or pt_regs into perf_read_regs
>>
>> I don't know enough about PPC to know what's going on, but reverting
>> the changes to perf_instruction_pointer() gets me reasonable 'perf
>> report' output with 3.11.
>
> This is an e300 core right ? (603...). Do that have an SIAR at all
> (Scott ?)

Yes, e300c3.

mh

-- 
Martin Hicks P.Eng.      |         mort@bork.org
Bork Consulting Inc.     |   +1 (613) 266-2296
