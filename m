Return-Path: <sneakums@zork.net>
Received: from zork.zork.net (zork.zork.net [64.81.246.102])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2E70E2BE83
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Nov 2004 05:36:21 +1100 (EST)
To: Keith Conger <keith.conger@gmail.com>
References: <1100847411.25521.42.camel@gaston>
	<1100852423.3855.2.camel@gaston> <1101083578.13597.5.camel@gaston>
	<6ullcuggfr.fsf@zork.zork.net>
	<4517b8e04112208383cc9b24c@mail.gmail.com>
From: Sean Neakums <sneakums@zork.net>
Date: Mon, 22 Nov 2004 18:36:02 +0000
In-Reply-To: <4517b8e04112208383cc9b24c@mail.gmail.com> (Keith Conger's
	message of "Mon, 22 Nov 2004 11:38:09 -0500")
Message-ID: <6uzn19g299.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gentoo-ppc-user@gentoo.org,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: TEST: Sleep patch #4
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Keith Conger <keith.conger@gmail.com> writes:

> Works great here also (15" 1GHz PB). One issue which may be unrelated
> I have some sound issues. For instance one a sound is played it sounds
> fine but if a sound is played right after its volume is extremely low.
> But with headphones this doesn't occur.

I have a similar problem post-resume -- sound from the speakers is
very quiet (although it seems to be louder at the very beginning) and
I had to plug and re-plug the headphones to get sound from them.  I
tried unloading and reloading snd_powermac, to no avail.
