Return-Path: <agx@sigxcpu.org>
Received: from honk1.physik.uni-konstanz.de (honk1.physik.uni-konstanz.de
	[134.34.140.224])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 322CB2BDEB
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Nov 2004 19:37:19 +1100 (EST)
Date: Tue, 23 Nov 2004 08:58:33 +0100
From: Guido Guenther <agx@debian.org>
To: Keith Conger <keith.conger@gmail.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, gentoo-ppc-user@gentoo.org
Message-ID: <20041123075833.GB15009@bogon.ms20.nix>
References: <1100847411.25521.42.camel@gaston> <1100852423.3855.2.camel@gaston>
	<1101083578.13597.5.camel@gaston> <6ullcuggfr.fsf@zork.zork.net>
	<4517b8e04112208383cc9b24c@mail.gmail.com>
	<6uzn19g299.fsf@zork.zork.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6uzn19g299.fsf@zork.zork.net>
Subject: Re: TEST: Sleep patch #4
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 22, 2004 at 06:36:02PM +0000, Sean Neakums wrote:
> Keith Conger <keith.conger@gmail.com> writes:
> 
> > Works great here also (15" 1GHz PB). One issue which may be unrelated
> > I have some sound issues. For instance one a sound is played it sounds
> > fine but if a sound is played right after its volume is extremely low.
> > But with headphones this doesn't occur.
> 
> I have a similar problem post-resume -- sound from the speakers is
> very quiet (although it seems to be louder at the very beginning) and
> I had to plug and re-plug the headphones to get sound from them.  I
> tried unloading and reloading snd_powermac, to no avail.
Could you check if:
 http://honk.physik.uni-konstanz.de/~agx/linux-ppc/kernel/alsa-2.6.9-rc2-revert.diff
helps?
 -- Guido
