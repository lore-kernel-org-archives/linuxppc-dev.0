Message-ID: <3F0C454C.6080106@earthlink.net>
Date: Wed, 09 Jul 2003 09:39:40 -0700
From: Dean Matsen <deanmatsen@earthlink.net>
To: Dan Malek <dan@embeddededge.com>
Cc: Eugene Surovegin <ebs@ebshome.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ethernet PHY chip discovery not working on 855T with  971/972
 chips
References: <3F0B7B28.7040902@earthlink.net> <5.1.0.14.2.20030708195315.038110e8@mail.ebshome.net> <3F0BA671.1050900@embeddededge.com> <3F0BAD39.9060708@earthlink.net> <3F0C2898.90508@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

>
> Dean Matsen wrote:
>
>> Yes, I see we have no pullup on that line. We do dedicated HVAC
>> applications, so we
>> don't need to do this search.
>
>
> But.......the hardware is broken. The MDIO is supposed to be
> an open-drain with a pullup. I guess you may be lucky the
> ends of the connection are driving the line proplerly, but it
> could be luck that will run out someday.
>
>
> -- Dan
>
Well, I don't disagree there. We're going to investigate updating the
schematics for future products. Thanks for the input.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
