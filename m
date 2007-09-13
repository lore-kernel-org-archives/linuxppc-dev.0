Return-Path: <jonsmirl@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.237])
	by ozlabs.org (Postfix) with ESMTP id 9D3CBDDEED
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Sep 2007 04:42:15 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so444614nzh
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Sep 2007 11:42:13 -0700 (PDT)
Message-ID: <9e4733910709131142y6bacc960xd6d15b3098b0bc3d@mail.gmail.com>
Date: Thu, 13 Sep 2007 14:42:13 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: Which 2.6 kernel for MPC5200
In-Reply-To: <fa686aa40709120814h6a73e4a5j5734d086401b0f2d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <46E57A9D.2020506@asist.si>
	<fa686aa40709101120u1310845et866b8fa6df7c5154@mail.gmail.com>
	<9e4733910709101622u6978baa6n8618975f75ae1315@mail.gmail.com>
	<20070912062819.GI23573@pengutronix.de>
	<9e4733910709120808i687ab5far924201f8a910759c@mail.gmail.com>
	<fa686aa40709120814h6a73e4a5j5734d086401b0f2d@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org, Domen Puncer <domen.puncer@telargo.com>,
	Babarovic Ivica <ivica.babarovic@asist.si>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/12/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 9/12/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> > On 9/12/07, Robert Schwebel <r.schwebel@pengutronix.de> wrote:
> > > We have the OSELAS.BSP patch stack for the PCM030 working ontop of
> > > Linus' git. It still uses an older version of the Bestcom patches, so if
> > > you do some work in that area, please keep me informed about your
> > > progress.
> >
> > What is the best way to proceed? I need to be on current git since we
> > are integrating a wireless driver that is tracking current git and the
> > mac80211 work.
> >
> > I have Phytec (pcm030) and Efika hardware but I don't have a 5200lite.
> > Our prototype hardware uses the pcm030 module on a custom baseboard.
> >
> > The best thing for me would be to get a FEC driver merged. That is the
> > largest piece of code  that is floating around. Getting that merged
> > would give me a stable base to build future patches on.
> >
> > I'd also like to get support for the pcm030 (minus real-time) merged.
> > That isn't a lot of code once FEC is in the kernel.
> >
> > Domen has posted this driver "[RFC PATCH v0.1] net driver: mpc52xx
> > fec". I can work on breaking that up, but I don't have a 5200lite so I
> > will have to port to pcm030. I don't want to start on this if someone
> > else is already doing it.
>
> Sylvain's bestcomm patches need be cleaned up and resubmitted before
> the next merge window opens.  AFAIK, the code is pretty much ready,
> and all the comments have been addressed.  All that is required is the
> final push to tidy the patchset and post to the list one more time.
> Sylvain said that he was going to get this done last weekend, but I
> haven't heard back from him yet.

I just noticed mail from Paul Mackerras
"Patches added to powerpc.git for-2.6.24 branch"

The MPC5200 ones aren't in the list.


> Sylvain, if you need help, please let me know.  I'll happily take on
> the last bit of tidy work if that's what is needed to be finished
> before the merge window.  (And it needs to be ready *before*, not
> during if I'm judging the prevailing winds correctly).
>
> Cheers,
> g.
> >
> > --
> > Jon Smirl
> > jonsmirl@gmail.com
> >
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> grant.likely@secretlab.ca
> (403) 399-0195
>


-- 
Jon Smirl
jonsmirl@gmail.com
