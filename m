From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sven LUTHER <luther@dpt-info.u-strasbg.fr>,
	<linuxppc-dev@lists.linuxppc.org>, <debian-powerpc@lists.debian.org>
Subject: Re: Success! (was Re: External Monitor under Pismo)
Date: Fri, 4 May 2001 15:57:29 +0200
Message-Id: <20010504135729.16644@mailhost.mipsys.com>
In-Reply-To: <20010504153459.A14533@lambda.u-strasbg.fr>
References: <20010504153459.A14533@lambda.u-strasbg.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Note that if you don't want to mess with XFree, I recently added the
>> ability to control the CRT & LCD outputs of the Rage M3 to aty128fb in my
>> rsync tree. The tool to control it is on www.penguinppc.org/~benh
>
>BTW, the recently released ibook is said to only have the capacity to mirror,
>not act as an independent display ? can that be or is it something limited in
>the mac drivers ? It has a 8MB embedded rage mobility 128, same as the
>titanium i think.

Don't know. Note that the support I added to aty128fb uses one head only. It
just allow you to turn on/off the LCD and CRT output, but it's only mirroring.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
