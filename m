Date: Tue, 26 Sep 2000 12:18:51 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Paul Mackerras <paulus@linuxcare.com.au>
cc: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org
Subject: Re: zeroing pages in the idle task?
In-Reply-To: <14782.63625.633424.277661@argo.linuxcare.com.au>
Message-ID: <Pine.HPX.4.10.10009261215350.24143-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 13 Sep 2000, Paul Mackerras wrote:

>
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

It's not only OF, on my MVME machines with PPCBUG, I get 190 Mhz instead
of 200. This value could be computed from the decrementer frequency and
the clock multiplier (can be obtained from HID1 on some processors and
has to be guessed on others). The 601 will require a different method, but
can still be estimated quite precisely I believe.

Now, is is truly worth the effort ?

	Gabriel (slowly reducing my email backlog after 2 weeks away)...


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
