From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Daniel Berlin <dan@cgsoftware.com>
Cc: <linuxppc-dev@lists.linuxppc.org>, <ajoshi@unixbox.com>
Subject: Re: [PATCH]: Make radeonfb work alot better with new powerbooks
Date: Thu, 8 Nov 2001 17:38:48 +0100
Message-Id: <20011108163848.15922@smtp.adsl.oleane.com>
In-Reply-To: <EDBD773A-D459-11D5-9D29-0030657B5340@cgsoftware.com>
References: <EDBD773A-D459-11D5-9D29-0030657B5340@cgsoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>On Thursday, November 8, 2001, at 05:22  AM, Benjamin Herrenschmidt
>wrote:
>
>>>
>>> This patch makes the radeonfb work a lot better on the rev b
>>> powerbooks.
>>> It's against benh's latest, as of last night.
>>
>> Heh, Great ! I ordered a new TiPb but didn't get it yet :)
>:)
>They are very nice.
>In case you were wondering, here's a rundown of how things work:
>Firewire is an LSI FW500 chip (AFAICT), and works with ohci1394 in your
>tree without any changes.

It's not UniNorth internal firewire ? weird...

>The ethernet phy is something i've never seen before (It works, being
>detected as a generic PHY). It's got an ID number that doesn't seem to
>be like any of the others we can detect, but i could be wrong.

Apple love using a new phy for each new model. I just hope it's not yet
another undocumented broadcom part... well if it is (which is probably
the case if it's a gigabit), we might have to wait for the darwin driver
to get updated before beeing able to do gigabit.

>Sound seems the same as the ibook2 (TAS chip).

Ok, looks like I'll finally have a good excuse to work on this driver :)

>The code to do i2c on the radeon and aty128fb doesn't seem that tricky
>to implement ( At least, from reading the xfree86 drivers), so i might
>take a whack at it.

Ok. New coders are always welcome ;) There are a lot of things that would
be great on both the M3 (r128) and the new radeon: better support for
external CRT, support for S-video output, better panel detect...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
