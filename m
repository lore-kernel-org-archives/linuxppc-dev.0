Date: Thu, 8 Nov 2001 12:05:25 -0500
Subject: Re: [PATCH]: Make radeonfb work alot better with new powerbooks
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v475)
Cc: <linuxppc-dev@lists.linuxppc.org>, <ajoshi@unixbox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Daniel Berlin <dan@cgsoftware.com>
In-Reply-To: <20011108163848.15922@smtp.adsl.oleane.com>
Message-Id: <CD7D4E51-D46A-11D5-B603-000393575BCC@cgsoftware.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thursday, November 8, 2001, at 11:38  AM, Benjamin Herrenschmidt
wrote:

>>
>> On Thursday, November 8, 2001, at 05:22  AM, Benjamin Herrenschmidt
>> wrote:
>>
>>>>
>>>> This patch makes the radeonfb work a lot better on the rev b
>>>> powerbooks.
>>>> It's against benh's latest, as of last night.
>>>
>>> Heh, Great ! I ordered a new TiPb but didn't get it yet :)
>> :)
>> They are very nice.
>> In case you were wondering, here's a rundown of how things work:
>> Firewire is an LSI FW500 chip (AFAICT), and works with ohci1394 in your
>> tree without any changes.
>
> It's not UniNorth internal firewire ? weird...
Sorry, sorry, i was looking at the wrong node (node order changed, and i
wasn't paying attention to the GUID's).
That's the bridge on my IDE drive.
It's uninorth internal.
>
>> The ethernet phy is something i've never seen before (It works, being
>> detected as a generic PHY). It's got an ID number that doesn't seem to
>> be like any of the others we can detect, but i could be wrong.
>
> Apple love using a new phy for each new model. I just hope it's not yet
> another undocumented broadcom part... well if it is (which is probably
> the case if it's a gigabit), we might have to wait for the darwin driver
> to get updated before beeing able to do gigabit.
>
>> Sound seems the same as the ibook2 (TAS chip).
>
> Ok, looks like I'll finally have a good excuse to work on this driver :)
>
>> The code to do i2c on the radeon and aty128fb doesn't seem that tricky
>> to implement ( At least, from reading the xfree86 drivers), so i might
>> take a whack at it.
> Ben.
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
