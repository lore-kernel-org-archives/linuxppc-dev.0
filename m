From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sven LUTHER <luther@dpt-info.u-strasbg.fr>,
	<linuxppc-dev@lists.linuxppc.org>, <debian-powerpc@lists.debian.org>
Subject: Re: Success! (was Re: External Monitor under Pismo)
Date: Fri, 4 May 2001 16:13:40 +0200
Message-Id: <20010504141340.14232@mailhost.mipsys.com>
In-Reply-To: <20010504160604.A14752@lambda.u-strasbg.fr>
References: <20010504160604.A14752@lambda.u-strasbg.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>So mirroring will work, i guess.

Well, it works fine on the Pismo, but the composite output may need
additional configuration of the composite encoder.

>for dual head you will need X, isn't it, fbdev seems broken (well at least
>those using fbgen) for dualhead anyway. Don't know if aty128fb uses fbdev.
>
>BTW, how does the rage 128 work, it has 1 accel engine that draws to the
>framebuffer memory, and one or more ramdac or digital out ports that send the
>fb data to the displays.

There are so many revisions... who knows ! The "dual head" chips do like you
said: one accel engine and 2 CRTCs & DACs.

>So i suppose the you will need to use a trick similar to the matrox one
to get
>dual headed accelerated X to work.
>
>But could it be possible to block this in hardware, and thus force mirroring
>only operation ?
>
>How many different rage 128 mobility are around anyway ?
>
>Friendly,


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
