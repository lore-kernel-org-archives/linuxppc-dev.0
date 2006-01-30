Return-Path: <jcrigby@gmail.com>
Message-ID: <4b73d43f0601301422m1315e6b7s11655acb8ba8a54d@mail.gmail.com>
Date: Mon, 30 Jan 2006 15:22:40 -0700
From: John Rigby <jcrigby@gmail.com>
To: Sylvain Munaut <tnt@246tnt.com>
Subject: Re: [PATCH] Add support for lite5200b board.
In-Reply-To: <4b73d43f0601301417jdbe4adbs39d48836419d5d3b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <43D65FE3.6080501@freescale.com> <43D66F54.8000404@246tNt.com>
	<43D751F8.9060204@aotek.es> <43D807E0.1090206@246tNt.com>
	<4b73d43f0601261329n73971003n9217374a1cc2db6f@mail.gmail.com>
	<43DD3FFC.3040608@246tNt.com>
	<4b73d43f0601301052n5cd032a5vb8c6f4d664966dc1@mail.gmail.com>
	<43DE772E.90805@246tNt.com>
	<4b73d43f0601301317j562233b6kc81b8e8f844c6bd1@mail.gmail.com>
	<4b73d43f0601301417jdbe4adbs39d48836419d5d3b@mail.gmail.com>
Cc: Linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

and the arch/ppc/bestcomm directory as well

looks like maybe you didn't do a git-update-index?

On 1/30/06, John Rigby <jcrigby@gmail.com> wrote:
> Ok checked out the git tree and applied the patch.
> The drivers/net/fec_mpc52xxx directory seems to be missing.
>
> On 1/30/06, John Rigby <jcrigby@gmail.com> wrote:
> > Thanks, I had tried stripping off the http: and adding the .git but
> > not just adding the .git.
> >
> >
> > On 1/30/06, Sylvain Munaut <tnt@246tnt.com> wrote:
> > > Ooops,
> > >
> > > git clone http://gitbits.246tnt.com/gitbits/linux-2.6-mpc52xx.git
> > >
> > > (notice the previously missing .git at the end)
> > >
> > >
> > >         Sylvain
> > >
> > > John Rigby wrote:
> > > > I tried:
> > > > git clone http://gitbits.246tnt.com/gitbits/linux-2.6-mpc52xx
> > > > and got:
> > > > defaulting to local storage area
> > > > Cannot get remote repository information.
> > > > Perhaps git-update-server-info needs to be run there?
> > > >
> > > >
> > > >
> > > > On 1/29/06, Sylvain Munaut <tnt@246tnt.com> wrote:
> > > >
> > > >>John Rigby wrote:
> > > >>
> > > >>>
> > > >>>On 1/25/06, *Sylvain Munaut* <tnt@246tnt.com <mailto:tnt@246tnt.co=
m>> wrote:
> > > >>>
> > > >>>
> > > >>>
> > > >>>    Should apply fine on vanilla. My suggestion for now is take va=
nilla,
> > > >>>    apply this patch, then the 2-3 patch from Andrey for BestComm =
and stuff.
> > > >>>
> > > >>>
> > > >>>I was working on getting bestcomm and fec working, but forward por=
ting
> > > >>>my old 2.6.10 code to current is turning out to be more difficult =
than I
> > > >>>expected.
> > > >>>If you already have working code then I'll stop working on them.
> > > >>>
> > > >>>Where are these patches?  I'm new to this list so I don't have muc=
h
> > > >>>history.
> > > >>>Would I find these patches in the archive?
> > > >>
> > > >>Checkout (with git)
> > > >>
> > > >>http://gitbits.246tNt.com/gitbits/linux-2.6-mpc52xx
> > > >>
> > > >>then apply
> > > >>
> > > >>http://gitbits.246tNt.com/patches/bcomm-to-split.diff
> > > >>
> > > >> (I haven't cleanly splitted it up yet and right now I must go, so =
it's
> > > >>probably gonna be in the git tree this week, under the 'bestcomm' h=
ead ;)
> > > >>
> > > >>
> > > >>Please report if it works fine on your board (both lite5200 and
> > > >>lite5200b reports are welcome). I only did quick tests.
> > > >>
> > > >>
> > > >>
> > > >>        Sylvain
> > > >>
> > > >
> > > >
> > >
> > >
> >
>
