Message-ID: <01a701c3e415$3a49ff40$026810ac@gilad>
From: "Gilad Rom" <gilad@romat.com>
To: "Alex Zeffertt" <ajz@cambridgebroadband.com>
Cc: <linux-atm-general@lists.sourceforge.net>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <1075117282.1504.17.camel@zambia.cambridgebroadband.com> <019201c3e413$7f45d3a0$026810ac@gilad> <1075125571.1504.28.camel@zambia.cambridgebroadband.com>
Subject: Re: [Linux-ATM-General] Announcement: MPHY now supported inmpc860sar
Date: Mon, 26 Jan 2004 16:03:51 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Okay. Thanks.

And now for my next question - Do you think the driver
should run on the 82xx family of chips? (e.g. 8260 and the likes)
these guys have 2 Utopia-II ports with support for up to 31 devices
per port. Coupled with this software, it could make for a highly
efficient DSLAM.

Gilad.

----- Original Message -----
From: "Alex Zeffertt" <ajz@cambridgebroadband.com>
To: "Gilad Rom" <gilad@romat.com>
Cc: <linux-atm-general@lists.sourceforge.net>;
<linuxppc-embedded@lists.linuxppc.org>
Sent: Monday, January 26, 2004 3:59 PM
Subject: Re: [Linux-ATM-General] Announcement: MPHY now supported
inmpc860sar


> It is currently only supported in SAR mode, and in that mode there is an
> upper limit of 4 UTOPIA phys.  However, there's no reason that support
> can't be added for MPHY in ESAR mode - in which the limit is 31 phys.  I
> suspect that adding such support would be easier now that Rodolfo has
> done most of the work.
>
> Alex
>
> PS I'm not the expert on this.  Rodolfo's sourceforge username is
> "zaigor".
>
> On Mon, 2004-01-26 at 13:51, Gilad Rom wrote:
> > This is very exciting news! (well, for me it is)
> >
> > How many PHY's in parallel are we talking about here?
> >
> > Thanks,
> > Gilad.
> >
> >
> > ----- Original Message -----
> > From: "Alex Zeffertt" <ajz@cambridgebroadband.com>
> > To: <linux-atm-general@lists.sourceforge.net>;
> > <linuxppc-embedded@lists.linuxppc.org>
> > Sent: Monday, January 26, 2004 1:41 PM
> > Subject: [Linux-ATM-General] Announcement: MPHY now supported in
mpc860sar
> >
> >
> > > Just a quick note to say that multi-phy is now supported by the
> > > mpc860sar ATM driver, thanks to a patch by Rodolfo Giometti.
> > >
> > > Page: http://sourceforge.net/projects/mpc860sar/
> > >
> > > Alex
> > >
> > >
> > >
> > > -------------------------------------------------------
> > > The SF.Net email is sponsored by EclipseCon 2004
> > > Premiere Conference on Open Tools Development and Integration
> > > See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> > > http://www.eclipsecon.org/osdn
> > > _______________________________________________
> > > Linux-atm-general mailing list
> > > Linux-atm-general@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/linux-atm-general
> > >
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
