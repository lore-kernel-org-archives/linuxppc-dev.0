Return-Path: <davem@davemloft.net>
Date: Wed, 09 Dec 2009 16:21:21 -0800 (PST)
Message-Id: <20091209.162121.256573183.davem@davemloft.net>
To: grant.likely@secretlab.ca
Subject: Re: Deprecating of_platform, the path from here...
From: David Miller <davem@davemloft.net>
In-Reply-To: <20091209.161550.168794100.davem@davemloft.net>
References: <fa686aa40912091406i2ef4e1b2u25c9f46b20786245@mail.gmail.com>
	<20091209.161550.168794100.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: David Miller <davem@davemloft.net>
Date: Wed, 09 Dec 2009 16:15:50 -0800 (PST)

> From: Grant Likely <grant.likely@secretlab.ca>
> Date: Wed, 9 Dec 2009 15:06:29 -0700
> 
>> 1) of_platform will be deprecated in preference of the platform bus.
> 
> What a shame, it's one of the cleanest driver probing models
> in the tree.

And BTW, have you folks who "decided" this considered at all the fact
that it is much easier to describe represent platform devices using
of OF devices rather than the other way around?

The platform device pdata mechanism requires data structure changes
and is not dynamically extensible, whereas OF devices are
fundamentally so.

I don't like the idea to get rid of of_platform devices at all.

OF devices are really clean, much like netlink messages, where
arbitrary named attributes can be added or removed without any data
structure changes at all.
