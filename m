Date: Sun, 8 Oct 2000 01:34:31 +0200
From: Samuel Rydh <samuel@ibrium.se>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Video driver bug
Message-ID: <20001008013431.A1138@ibrium.se>
References: <Pine.LNX.4.10.10010071939260.398-100000@cassiopeia.home> <Pine.LNX.3.96LJ1.1b7.1001007134822.9961B-100000@ofey.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.3.96LJ1.1b7.1001007134822.9961B-100000@ofey.earthlink.net>; from toe@unlserve.unl.edu on Sat, Oct 07, 2000 at 01:50:49PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Oct 07, 2000 at 01:50:49PM -0500, Takashi Oe wrote:
>
> On Sat, 7 Oct 2000, Geert Uytterhoeven wrote:
>
> > > This problem is observable if one starts MOL from the console. MOL
> > > changes the video mode on an inactive console in order to extract
> > > certain video mode parameters (like rowbytes).
>
> Is there anything wrong with using FB_ACTIVATE_TEST flag for this usage?
> With the flag, you get a legal var and active fb is untouched.
>

Well, using the FB_ACTIVATE_TEST only tells me whether a particular
mode is acceptable or not. I need the information encoded in the
fix structure which is only available for the active mode.

/Samuel


----------------------------------------------------------
 E-mail <samuel@ibrium.se>  WWW: <http://www.ibrium.se>
  Phone/fax: (home) +46 8 4418431, (work) +46 8 7908470
----------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
