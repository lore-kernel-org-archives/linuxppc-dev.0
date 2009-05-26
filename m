Return-Path: <John.Linn@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: RE: Initialize DBCR0 for PPC440 targets
Date: Tue, 26 May 2009 09:11:20 -0600
In-Reply-To: <6213bc560905242351r7682dcb2m898beef8b334e010@mail.gmail.com>
References: <6213bc560905190608j73f4191fxbd94158a2b1740c0@mail.gmail.com>
	<20090519235302.GA6333@yookeroo.seuss>
	<6213bc560905192250w4caa84aem9c0dedb2eed72fea@mail.gmail.com>
	<6213bc560905242330j31c14d22pabb67174e105d68c@mail.gmail.com>
	<fa686aa40905242339l51ee5656ue388cde6da253287@mail.gmail.com>
	<6213bc560905242351r7682dcb2m898beef8b334e010@mail.gmail.com>
From: John Linn <John.Linn@xilinx.com>
To: "srikanth krishnakar" <skrishnakar@gmail.com>
Message-ID: <20090526151126.A25A05A805F@mail103-dub.bigfish.com>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: srikanth krishnakar [mailto:skrishnakar@gmail.com]
> Sent: Monday, May 25, 2009 12:51 AM
> To: John Linn
> Cc: Linuxppc-dev@ozlabs.org
> Subject: Re: Initialize DBCR0 for PPC440 targets
> =

> Hi John,
> =

> I am not finding any conclusion of the plan to add DBCR0
> initialization code to head_44x.S after this discussion :

There was no conclusion and I haven't had time yet to chase it further.

> =

> http://www.nabble.com/Question-about-DBCR0-initialization-for-440-td23049=
044.html#a23049044
> =

> Can you please comment ?
> =

> Thanks,
> -Srikanth Krishnakar
> =

> On Mon, May 25, 2009 at 12:09 PM, Grant Likely
> <grant.likely@secretlab.ca> wrote:
> > On Mon, May 25, 2009 at 12:30 AM, srikanth krishnakar
> > <skrishnakar@gmail.com> wrote:
> >> Hello Grant,
> >>
> >> Is there any conclusion of the below discussion:
> >>
> >> http://www.nabble.com/Question-about-DBCR0-initialization-for-440-td23=
049044.html
> >>
> >> Xilinx target (virtex5) hangs (while running GDBServer & KGDB) without=

> >> the DBCR0 initialization.
> >>
> >> Can you please comment on this ?
> >
> > IIRC, John Linn was hacking on a patch. =A0Search the mailing list
> > archives for DBCR0.
> >
> > g.
> >
> > --
> > Grant Likely, B.Sc., P.Eng.
> > Secret Lab Technologies Ltd.
> >
> =

> =

> =

> --
> "The Good You Do, The Best You GET"
> =

> Regards
> Srikanth Krishnakar
> **********************


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
