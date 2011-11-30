Return-Path: <jwboyer@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
 [209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 751491007D1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2011 08:07:11 +1100 (EST)
Received: by vcbfl15 with SMTP id fl15so918996vcb.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 13:07:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1322686997.29041.11.camel@pasglop>
References: <1322550101-28520-1-git-send-email-tinamdar@apm.com>
 <1322686997.29041.11.camel@pasglop>
Date: Wed, 30 Nov 2011 16:07:08 -0500
Message-ID: <CA+5PVA6773ff0UUjwCqWRS1ytrhAJ=FLOaUFBs4A3TortGOBhg@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/40x: Add APM8018X SOC support
From: Josh Boyer <jwboyer@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, Tanmay Inamdar <tinamdar@apm.com>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 30, 2011 at 4:03 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2011-11-29 at 12:31 +0530, Tanmay Inamdar wrote:
>> The AppliedMicro APM8018X embedded processor targets embedded applications that
>> require low power and a small footprint. It features a PowerPC 405 processor
>> core built in a 65nm low-power CMOS process with a five-stage pipeline executing
>> up to one instruction per cycle. The family has 128-kbytes of on-chip memory,
>> a 128-bit local bus and on-chip DDR2 SDRAM controller with 16-bit interface.
>
> Thanks, looks much better.

Yes, agreed.  So much better I already sent it to Ben in a pull request.

josh
