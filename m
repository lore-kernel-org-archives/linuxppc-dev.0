From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David A. Gatwood" <dgatwood@gatwood.net>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: G4 boot crash problems with 2.4 "stable"
Date: Wed, 13 Feb 2002 22:06:16 +0100
Message-Id: <20020213210616.30410@smtp.wanadoo.fr>
In-Reply-To: <Pine.LNX.3.96.1020213125526.27925B-100000@gatwood.net>
References: <Pine.LNX.3.96.1020213125526.27925B-100000@gatwood.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> >Is there a 2.4 kernel source tarball around that is known to boot on
>> >Sawtooth (using BootX)?  Is there a way to yank the OpenPIC support?
>>
>> BootX isn't supported on any newworld mac. You should boot from OF,
>> using yaboot.
>
>BootX works fine for me with every 2.2 kernel I've tried.  It only fails
>for 2.4 TOT builds.  I very much doubt the boot mechanism is at fault.

Well, it can be for various reasons. For example, the interrupt tree
cannot be properly parsed, we don't get the OF "phandles" and we now
rely on them (MacOS don't keep them when it gets the device-tree).
Also, some bus mastering devices aren't properly shut down, potentially
screwing things up in memory while the kernel loads.

I would really recommend you give a try to yaboot before investigating
much further.

(Note: I do have a sawtooth here which just works with latest kernels)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
