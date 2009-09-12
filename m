Return-Path: <glikely@secretlab.ca>
Received: from mail-px0-f192.google.com (mail-px0-f192.google.com
	[209.85.216.192])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 75629B7B60
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 13 Sep 2009 00:06:14 +1000 (EST)
Received: by pxi30 with SMTP id 30so1491136pxi.7
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Sep 2009 07:06:12 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1252736925.8375.65.camel@pasglop>
References: <20090912054410.21847.63718.stgit@localhost.localdomain>
	<1252736925.8375.65.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 12 Sep 2009 08:05:52 -0600
Message-ID: <fa686aa40909120705wdc8928ei75e9b8c952d1e45@mail.gmail.com>
Subject: Re: [RFC] powerpc/irq: Add generic API for setting up cascaded IRQs
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Sep 12, 2009 at 12:28 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2009-09-11 at 23:46 -0600, Grant Likely wrote:
>> From: Grant Likely <grant.likely@secretlab.ca>
>>
>> prototype implementation. =A0This probably doesn't work at all right now=
.
>>
>> Ben, I'm posting this now to get your thoughts before I go too far down
>> this path.
>
> Looks ok. I was initially thinking about putting get_irq() in irq_host,
> but as we discussed on IRC, a host is not necessarily a PIC, and it's
> nice for the parent to have a way to setup/init the cascade in case
> it needs to do some HW tweaking there as well.

Cool.  Thanks for the review.  I'll continue on with this approach and
hopefully get something working this weekend.

> However, why cascade_setup() and not setup_cascade() which sounds
> somewhat more natural ? :-)

I'm a reverse polish kind of guy.  I preferring 'subject'_'action'
over 'action'_'subject' just because it groups like subjects together.
 But it doesn't matter much, especially in this case where 'subject'
is in a group of exactly 1.  :-)

I'll do whichever you prefer.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
