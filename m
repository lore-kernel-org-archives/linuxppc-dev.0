Date: Wed, 9 Aug 2000 20:26:36 +0200 (MET DST)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Backlight control on Lombard PB
In-Reply-To: <Pine.LNX.4.10.10008091940260.23221-100000@zirkon.biophys.uni-duesseldorf.de>
Message-ID: <Pine.SOL.3.95.1000809202341.5966C-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 9 Aug 2000, Michael Schmitz wrote:

> > It should be in the linux-pmac-benh branch then, yeah? I rsynced again
> > from linuxcare.com.au yesterday (or rather 2:00 UT this morning), and the
> > problem still remains. Is there anything else to do, upgrade to a newer
> > BootX perhaps, or whatever?
>
> Compile you own kernel, and add a || machine_is_compatible("PowerBook1,1")
> right after the || machine_is_compatible("AAPL,PowerBook1999") in
> arch/ppc/kernel/pmac_support.c:register_backlight_controller(). That fixed
> it for me. I'll resync and see what BenH did there later today.
>
Hmm, there is a  || machine_is_compatible("AAPL,PowerBook1,1")
in it. I'll check the file I rsynced at home later.

							Derek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
