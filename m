From: hollis@austin.ibm.com
Date: Tue, 22 Jan 2002 12:39:44 -0600
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Conflicts between network and Matrox G450
Message-ID: <20020122183944.GK510@austin.ibm.com>
References: <m3wuyaahpu.fsf@adsl-63-206-120-177.dsl.snfc21.pacbell.net> <vxlmeq1o1x.fsf@snoddas.lkpg.cendio.se> <20020122152500.GF510@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020122152500.GF510@austin.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sorry, the patch was too large to post and is located for the moment at
http://penguinppc.org/~hollis/matroxfb-20020108.diff

-Hollis

On Tue, Jan 22, 2002 at 09:25:00AM -0600, hollis@austin.ibm.com wrote:
> On Tue, Jan 22, 2002 at 03:02:34PM +0100, Jan Smith wrote:
> >
> > I have a IBM pSeries 610 where I try to install a Matrox G450 card
> > aka GXT130P in IBM language.
>
> The GXT130P is actually a G400. The G450 is the GXT135P.
>
> > The machine is working fine with a RedHat Linux run via a terminal
> > but when you are using the graphics card will the network interface
> > not start at all.
>
> Have you compared the boot logs from a working boot and a failed boot?
>
> > Any one who have used a Matrox G450 with ppclinux?
>
> I think the G400 is supposed to work with matroxfb on PPC (though I've never
> tested nor heard reports one way or the other). If you really do have a G450,
> that's problematic. With the attached patch (submitted to Marcelo recently; I
> don't know if it was applied), I experienced success exactly once. OTOH, Olaf
> said it worked for him every time. Your mileage may vary. Please provide
> feedback to the matroxfb maintainer (Petr Vandrovec <vandrove@vc.cvut.cz>) if
> it works or not.
>
> -Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
