Date: Wed, 13 Sep 2000 02:13:37 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Paul Mackerras <paulus@linuxcare.com.au>
cc: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org
Subject: Re: zeroing pages in the idle task?
In-Reply-To: <14782.63625.633424.277661@argo.linuxcare.com.au>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000913020841.1376E-100000@ofey.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Wed, 13 Sep 2000, Paul Mackerras wrote:

> Michel Lanners writes:
>
> > clock           : 195MHz
> >                   ^^^^^^
> > (by the way, this is wrong. Anybody with a fix?)
>
> I'm pretty sure that this is the number that OF is telling us, so if
> it's wrong, blame OF.  You don't have a G3 upgrade card in an older
> machine perhaps?
>
> Since the only use of this number is for oohs and aahs, there's not a
> lot of motivation to try and work out if OF is wrong and work out the
> correct number.

Could you possibly tell me how one might implement this?  That is: how one
would measure/calculate this.  On NuBus, there is no OF, so I'd like to
implement.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
