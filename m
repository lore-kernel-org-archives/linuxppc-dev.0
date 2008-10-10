Return-Path: <jonsmirl@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.26])
	by ozlabs.org (Postfix) with ESMTP id 38945DDEEF
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 16:06:59 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so118368qwb.15
	for <linuxppc-dev@ozlabs.org>; Thu, 09 Oct 2008 22:06:58 -0700 (PDT)
Message-ID: <9e4733910810092206r5ba516ddv3d3ec910634431f5@mail.gmail.com>
Date: Fri, 10 Oct 2008 01:06:58 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: [RFC 0/6] Proposal for a Generic PWM Device API
In-Reply-To: <1223614943.8157.158.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <cover.1223482372.git.bgat@billgatliff.com>
	<1223608819.8157.127.camel@pasglop> <48EED4D1.2040506@billgatliff.com>
	<1223614943.8157.158.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Bill Gatliff <bgat@billgatliff.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 10, 2008 at 1:02 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Thu, 2008-10-09 at 23:06 -0500, Bill Gatliff wrote:
>> Benjamin Herrenschmidt wrote:
>> > On Wed, 2008-10-08 at 11:43 -0500, Bill Gatliff wrote:
>> >> This series proposes a "generic PWM" driver API.
>> >>
>> >> This proposed API is motivated by the author's need to support
>> >> pluggable devices; a secondary objective is to consolidate the
>> >> existing PWM implementations behind an agreeable, consistent,
>> >> redundancy-reducing interface.
>> >
>> >  .../...
>> >
>> > You should send your patches to the main linux kernel list !
>>
>> Perhaps.  But it seemed more relevant to this crowd, and the linux-embedded
>> crowd, and the linux-arm-kernel crowd.
>
> Sure but if you want then applied, you probably still need lkml and
> andrew.
>
>> At the very least, it made sense to present it in this sort of venue first.
>> Given that it's a "global" API proposal, I suppose I'll have to run it by lkml
>> at some point--- unless one of the aforementioned groups can mainline it themselves.
>
> For review and comments, sure.


What do the device tree deities have to say about PWM support?


-- 
Jon Smirl
jonsmirl@gmail.com
