Subject: Re: HZ in 2.6 on PPC32
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <1061654591.1251.34.camel@thor.holligenstrasse29.lan>
References: <1061654591.1251.34.camel@thor.holligenstrasse29.lan>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1061657994.772.6.camel@gaston>
Mime-Version: 1.0
Date: Sat, 23 Aug 2003 18:59:54 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2003-08-23 at 18:03, Michel Dänzer wrote:
> Why is this still defined to 100? I'm running at 1000 now, and it makes
> a huge difference for interactivity. Moreover, CONFIG_PREEMPT now makes
> things even better instead of worse. :)
>
> If the reason is the slow PPC32 CPUs still around, maybe make it a
> config option?

A config option would probably be a better idea, I doubt lots of embedded
or low end configs wants HZ at 1000... Regarding CONFIG_PREEMPT, it's
really weird that it "makes things worse" for you with HZ at 100. But
that may also be the 2.6-test scheduler suckyness...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
