Message-ID: <3F0F468F.1050909@earthlink.net>
Date: Fri, 11 Jul 2003 16:21:51 -0700
From: Dean Matsen <deanmatsen@earthlink.net>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ethernet PHY chip discovery not working on 855T with 971/972
 chips
References: <3F0C8112.5060001@earthlink.net> <20030709212145.49E24C6D82@atlas.denx.de> <20030711151834.GU17433@ip68-0-152-218.tc.ph.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

>On Wed, Jul 09, 2003 at 11:21:40PM +0200, Wolfgang Denk wrote:
>
>
>
>>In message <3F0C8112.5060001@earthlink.net> you wrote:
>>
>>
>>>I think the search should be made smarter (especially, keep going to
>>>the next address until it has gone through ALL address w/o finding a
>>>valid ID).  The kernel could still panic if it can't find any PHY chip,
>>>but not the first time it reads the floating line and can't find the
>>>answer in its table.  The odds of reading a valid PHY ID from the
>>>floating line is phenominally low.  I'd submit a proposed patch for
>>>this, but it doesn't sound like anyone else thinks this is important
>>>enough to warrant a change.
>>>
>>>
>>I agree that it makes little sense for th kernel to panic if it finds
>>an unsupported PHY id.
>>
>>
>>
>>>the automatic PHY search will work.  Unless the pullup is required for
>>>non-search applications (which I assert it isn't), then I think the code
>>>should be fixed, not the hardware.
>>>
>>>
>>We changed this in our kernel tree some time ago. If no valid PHY  is
>>found  we simply do not enable the interface, but we do not panic any
>>more.
>>
>>
>
>Which raises two fun questions:
>1) Do you plan on ever trying to re-sync your 2.4 tree with the
>community tree (which should become kernel.org before too long)?
>2) Do you plan on trying to keep in sync with 2.6 now that it's coming
>up on us?
>
>--
>Tom Rini
>http://gate.crashing.org/~trini/
>
>
>
>
>
Somewhere in this discussion thread I saw that the 2.4 kernel is closed for
patches (I just joined this list, so I didn't know that).

Would it help if I came up with a 2.5 patch for fec.c? I made a few minor
changes that will make it behave friendlier for all [to whom it is not
already being totally friendly], and I see the 2.5 kernel could use some
of the same changes.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
