Return-Path: <sneakums@zork.net>
Received: from zork.zork.net (zork.zork.net [64.81.246.102])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 09BA22BDF2
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Nov 2004 19:41:08 +1100 (EST)
To: Guido Guenther <agx@debian.org>
References: <1100847411.25521.42.camel@gaston>
	<1100852423.3855.2.camel@gaston> <1101083578.13597.5.camel@gaston>
	<6ullcuggfr.fsf@zork.zork.net>
	<4517b8e04112208383cc9b24c@mail.gmail.com>
	<6uzn19g299.fsf@zork.zork.net> <20041123075833.GB15009@bogon.ms20.nix>
From: Sean Neakums <sneakums@zork.net>
Date: Tue, 23 Nov 2004 08:40:53 +0000
In-Reply-To: <20041123075833.GB15009@bogon.ms20.nix> (Guido Guenther's message
	of "Tue, 23 Nov 2004 08:58:33 +0100")
Message-ID: <6uk6sdez56.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Keith Conger <keith.conger@gmail.com>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	gentoo-ppc-user@gentoo.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: TEST: Sleep patch #4
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guido Guenther <agx@debian.org> writes:

> On Mon, Nov 22, 2004 at 06:36:02PM +0000, Sean Neakums wrote:
>> Keith Conger <keith.conger@gmail.com> writes:
>> 
>> > Works great here also (15" 1GHz PB). One issue which may be unrelated
>> > I have some sound issues. For instance one a sound is played it sounds
>> > fine but if a sound is played right after its volume is extremely low.
>> > But with headphones this doesn't occur.
>> 
>> I have a similar problem post-resume -- sound from the speakers is
>> very quiet (although it seems to be louder at the very beginning) and
>> I had to plug and re-plug the headphones to get sound from them.  I
>> tried unloading and reloading snd_powermac, to no avail.
> Could you check if:
>  http://honk.physik.uni-konstanz.de/~agx/linux-ppc/kernel/alsa-2.6.9-rc2-revert.diff
> helps?

Increasing DRC Range as suggested by Ben seems to fix my problem.

I note that this patch seems to have a few hunks relating to 48KHz --
does this do anything to help applications that do not resample audio
to 44.1KHz?  The asoundrcs using dmix to adjust the rate that I have
seen posted produce rather poor sound.
