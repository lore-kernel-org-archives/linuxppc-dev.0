From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Derrik Pates <dpates@dsdk12.net>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	Ani Joshi <ajoshi@shell.unixbox.com>
Subject: Re: GeForce on PPC == _no work_
Date: Sun, 28 Oct 2001 21:41:10 +0100
Message-Id: <20011028204110.4499@smtp.wanadoo.fr>
In-Reply-To: <Pine.LNX.4.33.0110281153080.24940-100000@andromeda.dsdk12.net>
References: <Pine.LNX.4.33.0110281153080.24940-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I don't suppose anyone knows if there's any hope of reverse-engineering
>the MacOS 9 or OS X nVidia drivers?

If your problem is only to get the display to the DVI connector,
then it should be doable with register dumps from macos and/or
some tracing of the macos driver.

I don't have such a machine so I can't try hacking the driver,
but maybe Ani has ideas about what registers to look for ?

Ani, if you tell me how to get at these, I can write a macos 9
tool to dump them.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
