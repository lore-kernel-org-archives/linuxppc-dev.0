Date: Sun, 2 May 2004 19:12:58 +0200
From: Cedric Pradalier <cedric.pradalier@inrialpes.fr>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] simple class for adb
Message-Id: <20040502191258.7a2d0eb0.cedric.pradalier@inrialpes.fr>
In-Reply-To: <20040502040724.GA11529@pants.nu>
References: <20040501182659.GB18859@suse.de>
	<1083450972.29595.203.camel@gaston>
	<20040502040724.GA11529@pants.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 1 May 2004 21:07:25 -0700,
Brad Boyer gracefully wrote:
>
>On Sun, May 02, 2004 at 08:36:12AM +1000, Benjamin Herrenschmidt wrote:
>> I'm not sure I want to keep /dev/adb forever.... This is at best a
>> workaround so that udev creates it. Ultimately, we want a real adb
>> bus in the device-model and a different mecanism to send special
>> commands to the system controller. I think somebody from the m68k
>> folks is already working on the ADB bus stuff though.
>
>Slowly but surely, yes. Although perhaps just slowly. I've got part
>of it written, but I haven't had any time the last month or so due
>to my real job. I will probably have more time to finish up the
>new ADB subsystem later this month.
>
>I definitely agree on getting rid of most of the reasons for
>/dev/adb, but I'm not sure what all people use through it. I know
>the trackpad tool uses it, but I'm not sure of anything else.
>Does the sleep stuff use /dev/adb or /dev/pmu?
>
>	Brad Boyer
>	flar@allandria.com
>
>
>
>

Hi all,

	I'm not sure it is related but I noticed on my ibook 2.2,
kernel <= 2.6.5, that sometimes some keyboards event are missed. With
xev, I keep seeing a key pushed (and repeating) whereas I released it.
To bring the system back to normal, I have to press and release the
repeating key, just to generate a release event, I guess.

Since it seems to be ppc-specific, I suspect adb. Does it make sense ?
Is it a known problem ?

--
Cedric

"[Of course] I'm French! Why do think I have this outrageous
accent, you silly king-a?!"  Monty Python and the Holy Grail

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
