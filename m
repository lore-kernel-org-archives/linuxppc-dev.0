Message-ID: <3C07FA77.3060007@embeddededge.com>
Date: Fri, 30 Nov 2001 16:30:31 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: "John W. Linville" <linville@lvl7.com>
Cc: ppclist <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mpc860p specific patches?
References: <3C07F36B.C82F4B57@lvl7.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


John W. Linville wrote:

> Forgive me if this is a stupid question, but...  I'm wondering if there
> are any patches specific to using an MPC860P (note the "P") with a 2.4.x
> kernel?

No.

> I've got 2.4.14 configured for an MPC860T, and I seem to get corrupted
> packets over the FEC.

I haven't responded to your longer message, yet, but you don't want
PowerPC kernels from kernel.org.  The patches aren't ever quite right up there.
Check out penginppc.org and follow the links to the kernel source.
Normally, I would recommend using the _devel version, but the kids have
been making a mess of it lately, so just download the normal 2.4 version :-).

> Has anyone seen/heard of a problem like this with the 860P?  I have the
> same problem on a 2.2.16 kernel using the same boot code.

Long ago, there were changes to the pin configurations between a couple
of revisions of silicon, but the newer FEC drivers detect the version at
run time and set them accordingly.

Is this hardware that is known to work, or is this something new?  As I
always tell people, the 8xx core can't create worst case bus activity,
but once you turn on a DMA device (anything in the CPM or FEC) the bus
activity radically changes and you get worst case timing.


Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
