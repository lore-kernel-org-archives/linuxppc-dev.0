Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.243])
	by ozlabs.org (Postfix) with ESMTP id 0DAE0DDF48
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Mar 2009 16:41:17 +1100 (EST)
Received: by ag-out-0708.google.com with SMTP id 33so1574240agc.0
	for <linuxppc-dev@ozlabs.org>; Fri, 06 Mar 2009 21:41:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <fa686aa40903062022i2211ccdfu1bffab54749615d8@mail.gmail.com>
References: <49B1605C.7090709@embeddedarm.com>
	<20090306184038.GA20537@zod.rchland.ibm.com>
	<49B19AE0.3080609@embeddedarm.com> <49B1A47F.8040005@embeddedarm.com>
	<fa686aa40903062022i2211ccdfu1bffab54749615d8@mail.gmail.com>
Date: Fri, 6 Mar 2009 22:41:15 -0700
Message-ID: <fa686aa40903062141n210f81d7g9f11154f3c78cadc@mail.gmail.com>
Subject: Re: [PATCH, RFC]
From: Grant Likely <grant.likely@secretlab.ca>
To: Eddie Dawydiuk <eddie@embeddedarm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 6, 2009 at 9:22 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Fri, Mar 6, 2009 at 3:32 PM, Eddie Dawydiuk <eddie@embeddedarm.com> wrote:
>> Hello,
>>
>> Let's try this one more time. The last patch was using the clocks for a
>> custom board based on the Yosemite board and was referencing a non-existent
>> ethNadr( I forgot to pull out this code out).
>
> But the question remains: Why do you need simpleboot support for
> Yosemite when you can use a uImage or cuImage with u-boot?

On a more general note; this patch also diverges from the original
model for simple image.  The idea behind simpleimage was that it would
contain a fully formed device tree, with no fixups necessary.  I want
to think carefully before diverging from that.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
