Return-Path: <keith.conger@gmail.com>
Received: from mproxy.gmail.com (mproxy.gmail.com [216.239.56.250])
	by ozlabs.org (Postfix) with ESMTP id 37D0F2BDB5
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Nov 2004 03:45:09 +1100 (EST)
Received: by mproxy.gmail.com with SMTP id u33so119872cwc
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Nov 2004 08:45:08 -0800 (PST)
Message-ID: <4517b8e04112208383cc9b24c@mail.gmail.com>
Date: Mon, 22 Nov 2004 11:38:09 -0500
From: Keith Conger <keith.conger@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, gentoo-ppc-user@gentoo.org
In-Reply-To: <6ullcuggfr.fsf@zork.zork.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <1100847411.25521.42.camel@gaston> <1100852423.3855.2.camel@gaston>
	<1101083578.13597.5.camel@gaston> <6ullcuggfr.fsf@zork.zork.net>
Subject: Re: TEST: Sleep patch #4
Reply-To: Keith Conger <keith.conger@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Works great here also (15" 1GHz PB). One issue which may be unrelated
I have some sound issues. For instance one a sound is played it sounds
fine but if a sound is played right after its volume is extremely low.
But with headphones this doesn't occur.

Thanks again for your hard work.

Keith


On Mon, 22 Nov 2004 13:29:44 +0000, Sean Neakums <sneakums@zork.net> wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > Ok, here's the 4th iteration of the patch. It includes John Steele
> > Scott fixes for cpufreq and the sound driver and fixes a problem
> > where memory refresh wouldn't properly be re-enabled on the video
> > chip upon wakeup. I also cleaned a bit more the MDLL reset code for
> > r300, plus a couple of other things.
> >
> > http://gate.crashing.org/~benh/albook-ibookg4-sleep-4.diff
> 
> Works great now (15" 1.5GHz PB).
> 
> Many thanks!
> 
> 
> 
> 
> --
> To UNSUBSCRIBE, email to debian-powerpc-REQUEST@lists.debian.org
> with a subject of "unsubscribe". Trouble? Contact listmaster@lists.debian.org
> 
> 


-- 
Keith Conger
keith DOT conger AT gmail DOT com
http://pimpstation.org
