Date: Sat, 1 May 2004 21:07:25 -0700
From: Brad Boyer <flar@allandria.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Olaf Hering <olh@suse.de>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Greg KH <greg@kroah.com>
Subject: Re: [PATCH] simple class for adb
Message-ID: <20040502040724.GA11529@pants.nu>
References: <20040501182659.GB18859@suse.de> <1083450972.29595.203.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1083450972.29595.203.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, May 02, 2004 at 08:36:12AM +1000, Benjamin Herrenschmidt wrote:
> I'm not sure I want to keep /dev/adb forever.... This is at best a
> workaround so that udev creates it. Ultimately, we want a real adb
> bus in the device-model and a different mecanism to send special
> commands to the system controller. I think somebody from the m68k
> folks is already working on the ADB bus stuff though.

Slowly but surely, yes. Although perhaps just slowly. I've got part
of it written, but I haven't had any time the last month or so due
to my real job. I will probably have more time to finish up the
new ADB subsystem later this month.

I definitely agree on getting rid of most of the reasons for
/dev/adb, but I'm not sure what all people use through it. I know
the trackpad tool uses it, but I'm not sure of anything else.
Does the sleep stuff use /dev/adb or /dev/pmu?

	Brad Boyer
	flar@allandria.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
