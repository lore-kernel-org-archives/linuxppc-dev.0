Subject: Re: ATM driver for 8260 (linux 2.4.x)
From: James Campbell <jcampbell@omnigon.com>
To: linuxppc-embedded@lists.linuxppc.org
Cc: linux-atm-general@lists.sourceforge.net
In-Reply-To: <3C1DC1F3.844C7B18@cambridgebroadband.com>
References: <20011215162000.1813.qmail@web9705.mail.yahoo.com>
	<3C1DC1F3.844C7B18@cambridgebroadband.com>
Content-Type: text/plain
Date: 17 Dec 2001 08:27:33 -0800
Message-Id: <1008606453.1383.1.camel@skoll.omnigon.com>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I've ported the 860sar for the MPC8260 under 2.4.16.

It currently supports AAL0, AAL1, Semi-working Forward Error Correction
AAL1 and AAL5.

Let me clean it up a bit, and I'll post a patch.

Cheers,

James Campbell

On Mon, 2001-12-17 at 01:59, Alex Zeffertt wrote:
>
> Hello None (!)
>
> I have written a driver for the 860 (http://mpc860sar.sourceforge.net).  This supports linux 2.4.4.
> If you fail to find something written specifically for the 8260 you may want to try porting this.
>
> Alex
>
> None Atall wrote:
> >
> > Where can I find a ATM driver for 8260,
> > for 2.4.x kernel? Has anyone imported any?
> > I have a Motorola ADS 8260 board.
> >
> >                            Thanks.
> >                             D. Meidanis
> >
>
>
--
James Campbell          -|-   Embedded Systems Engineer
jcampbell@omnigon.com   -|-     Omnigon International
pgp:  C138 0E47 5200 40A3 5D09 682E D53F A137 49AE 7171
work: +1.760.804.8884 x 332       cell: +1.760.492.1176
--
"Computer games don't affect kids; I mean if Pac-Man
affected us as kids, we'd all be running around darkened
rooms, munching magic pills and listening to repetitive
electronic music."
         -Kristian Wilson, Nintendo, Inc. 1989


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
