Date: Sat, 07 Apr 2001 22:34:11 -0700
Subject: Re: Coding device driver for a minor device.
From: Karsten Jeppesen <kj-list@jeppesens.com>
To: David Schleef <ds@schleef.org>,
	Karsten Jeppesen <karsten@jeppesens.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B6F54661.5D5B%kj-list@jeppesens.com>
In-Reply-To: <20010407175334.A27797@stm.lbl.gov>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks Dave,

Looking through it I decided for major 10, minor 156, the lcd front panel.
It is not merely a local use device rather I have a new ppc platform which
has a front VFD, two push buttons and a tri-state led.

Thaks again,

karsten

> From: David Schleef <ds@schleef.org>
> Reply-To: David Schleef <ds@schleef.org>
> Date: Sat, 7 Apr 2001 17:53:34 -0700
> To: Karsten Jeppesen <karsten@jeppesens.com>
> Cc: linuxppc-dev@lists.linuxppc.org
> Subject: Re: Coding device driver for a minor device.
>
>
> On Sat, Apr 07, 2001 at 12:42:19PM -0700, Karsten Jeppesen wrote:
>>
>> I have done modules.
>>
>> Now the problem is that I have 2 pushbuttons that I would like to read.
>> Looking in the device list I see dev 10, which has a lot of - let us call it
>> miscellaneous - content. This one seems to fit here. Maybe as a minor 185 or
>> 186.
>> But how do I locate the device driver for device major 10?
>>
>> I am certain there is a simple way - somebody knows it?
>
> See linux/include/linux/miscdevice.h.  And you should probably use
> a minor in the range of 240-255, as those are reserved for local
> use.
>
>
>
> dave...
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
