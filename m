Date: Tue, 2 Apr 2002 13:12:35 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Cc: paulus@samba.org, linux-galileo@source.mvista.com,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
Message-ID: <20020402201235.GA28287@opus.bloom.county>
References: <0203210213.AA15856@ivan.Harhan.ORG> <3C99801A.8070002@embeddededge.com> <15526.51621.991410.781713@argo.ozlabs.ibm.com> <3CA8A96D.9040309@embeddededge.com> <15529.17031.622986.926261@argo.ozlabs.ibm.com> <3CA9EA93.5000404@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CA9EA93.5000404@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Apr 02, 2002 at 12:29:55PM -0500, Dan Malek wrote:
>
> I'm glad you found _some_ of the humor in it :-)
>
> Paul Mackerras wrote:
>
>
> >Two reasons: (a) it seems to be that (for example) most of the if
> >statements in arch/ppc/config.in are concerned with embedded boards,
>
> Well, yes, and at one point I tried to create config.in files that were
> unique to the boards/peripherals that were just callouts from config.in.
> That didn't last long because all of these were incorporated (not by me :-)
> into config.in and other places.  I thought having these board specific
> configuration files was kind of nice, kept arch/ppc/config.in cleaner,
> kept the interdependencies localized to a sensible place, but I guess
> someone thought different when it got merged from the development tree.

It was probably me.  One thing I want to do in the 2.5 tree is make
arch/ppc/platforms/{8xx,4xx}.in and source those from
arch/ppc/config.in, as well as move network things to network Config
files, and so on.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
