Date: Thu, 14 Mar 2002 14:40:09 -0900
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Nasty ATI/tulip interaction
Message-ID: <20020314144009.A26309@plato.local.lan>
References: <E16lD25-00006q-00@piglet.grunz.lu> <Pine.LNX.3.96.1020314143728.24843U-100000@gatwood.net>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.3.96.1020314143728.24843U-100000@gatwood.net>; from dgatwood@gatwood.net on Thu, Mar 14, 2002 at 02:40:08PM -0800
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Mar 14, 2002 at 02:40:08PM -0800, David A. Gatwood wrote:
>
> On Wed, 13 Mar 2002, Michel Lanners wrote:
>
> > Any specific reason to stay with a 2.2 kernel? I can run 2.4.18 mainline
> > straight-Linus (sorry, straight-Marcello) on my 7600, with a Promise as
> > well.
>
> Ran into nasty problems booting with BootX on a G4, as I was trying to
> have exactly the same environment on my G4 as I was going to have on the
> PowerBase.  Then, I finaly got the PowerBase.  So basically, it was legacy
> from having needed to get the system up and running before the final
> machine actually arrived.  Caused some hiccups.

you must not use BootX on newworld hardware (such as G4s).  you must
use yaboot.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
