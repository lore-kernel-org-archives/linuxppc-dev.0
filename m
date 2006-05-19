Return-Path: <paul@briny.ondioline.org>
Received: from jenny.ondioline.org (jenny.ondioline.org [66.220.1.122])
	by ozlabs.org (Postfix) with ESMTP id D690A679FF
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 23:25:47 +1000 (EST)
From: Paul Collins <paul@briny.ondioline.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: snd-aoa status update / automatic driver loading
References: <1147860564.14395.6.camel@johannes>
	<60381eeb0605180025v2495715scb345d7067518ecc@mail.gmail.com>
	<1147947784.15507.46.camel@johannes>
Date: Fri, 19 May 2006 23:20:29 +1000
In-Reply-To: <1147947784.15507.46.camel@johannes> (Johannes Berg's message of
	"Thu, 18 May 2006 12:23:04 +0200")
Message-ID: <87wtcirw0y.fsf@briny.internal.ondioline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: list <linuxppc-dev@ozlabs.org>, linuxppc-dev,
	Eddy =?utf-8?Q?Petri=C5=9For?= <eddy.petrisor@gmail.com>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg <johannes@sipsolutions.net> writes:

> On Thu, 2006-05-18 at 10:25 +0300, Eddy Petri=C5=9For wrote:
>
>> Any chance for 5,2 ? What is needed for it? Codec only?
>
> I don't know. If you try loading the modules, the kernel will tell you
> something about an unhandled layout id. Alternatively, you can find the
> layout-id file in your /proc/device-tree/ and tell me the number in it.
> The rest I can figure out.

I have a PowerBook5,4 here and I'd be happy to test support for it.
The hardware is identified by snd-powermac as "PowerMac Snapper" and
the layout ID appears to be "3".

[briny(device-tree)] od -c pci@f2000000/mac-io@17/i2s@10000/i2s-a@10000/sou=
nd/layout-id
0000000  \0  \0  \0   3
0000004

--=20
Dag vijandelijk luchtschip de huismeester is dood
