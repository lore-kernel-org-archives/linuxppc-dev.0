Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zbR816kLRzF0xk
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Feb 2018 01:06:09 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 neelegup@linux.vnet.ibm.com, stable@vger.kernel.org
Subject: Re: rtc-opal: Fix handling of firmware error codes, prevent busy loops
In-Reply-To: <20180206124212.GQ3404@piout.net>
References: <1470102616-18346-1-git-send-email-stewart@linux.vnet.ibm.com>
 <20180206022646.GP3404@piout.net> <87bmh24rq0.fsf@concordia.ellerman.id.au>
 <20180206124212.GQ3404@piout.net>
Date: Wed, 07 Feb 2018 01:06:07 +1100
Message-ID: <87h8quw6uo.fsf@concordia.ellerman.id.au>
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

Alexandre Belloni <alexandre.belloni@bootlin.com> writes:

> On 06/02/2018 at 16:22:47 +1100, Michael Ellerman wrote:
>> > Just a note to let you know that this patch should have gone through my
>> > tree but it was not sent to linux-rtc or me.
>> 
>> Sorry, I saw it had been languishing for a long time and assumed you'd
>> missed it.
>> 
>> Happy to revert/rework it if you're not happy with it.
>> 
>
> No, that's fine. It's just that the commit title stands out when using
> git log --oneline and that triggered my OCD ;)

Oh no! Now I'm *really* sorry, that's the worst! :)

cheers
