Message-ID: <3F0BAD39.9060708@earthlink.net>
Date: Tue, 08 Jul 2003 22:50:49 -0700
From: Dean Matsen <deanm@earthlink.net>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: Eugene Surovegin <ebs@ebshome.net>,
	Dean Matsen <deanmatsen@earthlink.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ethernet PHY chip discovery not working on 855T with  971/972
 chips
References: <3F0B7B28.7040902@earthlink.net> <5.1.0.14.2.20030708195315.038110e8@mail.ebshome.net> <3F0BA671.1050900@embeddededge.com>
In-Reply-To: <3F0BA671.1050900@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

>
> Eugene Surovegin wrote:
>
>> It usually means that your hw lacks pull-up on MII MDIO line.
>
>
> Yep, and even when PHYs indicate they have internal pull-ups, either
> they don't or they aren't sufficient.
>
>
> -- Dan
>
>
>
>
Yes, I see we have no pullup on that line. We do dedicated HVAC
applications, so we
don't need to do this search. Our dedicated software wouldn't talk to
the chip
at the wrong address.

Don't you think the fix from my original message should still be
considered for
integration into the kernel? It will improve the odds that the kernel can
auto-detect someone's hardware....

Thanks
Dean


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
