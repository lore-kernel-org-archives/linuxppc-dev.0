Date: Sat, 7 Apr 2001 17:53:34 -0700
From: David Schleef <ds@schleef.org>
To: Karsten Jeppesen <karsten@jeppesens.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Coding device driver for a minor device.
Message-ID: <20010407175334.A27797@stm.lbl.gov>
Reply-To: David Schleef <ds@schleef.org>
References: <B6F4BBA9.5D29%karsten@jeppesens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B6F4BBA9.5D29%karsten@jeppesens.com>; from karsten@jeppesens.com on Sat, Apr 07, 2001 at 12:42:19PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Apr 07, 2001 at 12:42:19PM -0700, Karsten Jeppesen wrote:
>
> I have done modules.
>
> Now the problem is that I have 2 pushbuttons that I would like to read.
> Looking in the device list I see dev 10, which has a lot of - let us call it
> miscellaneous - content. This one seems to fit here. Maybe as a minor 185 or
> 186.
> But how do I locate the device driver for device major 10?
>
> I am certain there is a simple way - somebody knows it?

See linux/include/linux/miscdevice.h.  And you should probably use
a minor in the range of 240-255, as those are reserved for local
use.



dave...


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
