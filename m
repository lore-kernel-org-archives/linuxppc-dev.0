Subject: Re: [Linux-ATM-General] Announcement: MPHY now supported
	inmpc860sar
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: Zoran Stojsavljevic <zoransto@dkts.co.yu>
Cc: Gilad Rom <gilad@romat.com>,
	"linux-atm-general@lists.sourceforge.net" <linux-atm-general@lists.sourceforge.net>,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>,
	zaigor@sourceforge.net
In-Reply-To: <001601c3ebe7$5ba13490$30c8a8c0@zorans>
References: <1075117282.1504.17.camel@zambia.cambridgebroadband.com>
	 <019201c3e413$7f45d3a0$026810ac@gilad>
	 <1075125571.1504.28.camel@zambia.cambridgebroadband.com>
	 <01a701c3e415$3a49ff40$026810ac@gilad>
	 <001601c3ebe7$5ba13490$30c8a8c0@zorans>
Content-Type: text/plain
Message-Id: <1075988635.2925.9.camel@zambia.cambridgebroadband.com>
Mime-Version: 1.0
Date: 05 Feb 2004 13:43:55 +0000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Zoran

I wouldn't imagine that the patch would apply to the mpc8260 driver and
work.  However, it would probably be useful to look at it for pointers
if you were thinking of porting MPHY support to the mpc8260.

BTW, to get the patch try

cvs -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/mpc860sar checkout -A atm  # Top of tree is now MPHY
cd atm
cvs -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/mpc860sar diff -u -r single-utopia-phy  # compare with SPHY branch

Alex

On Thu, 2004-02-05 at 12:54, Zoran Stojsavljevic wrote:
> Quick question to you all... I walked through Pete's 8260 ATM driver, and I
> saw
> (as far as I can understand) that Pete's driver is set to support single PHY
> mode.
>
> So, the question here is: do we need Rodolfo Giometti's patch to be applied
> to mpc8260
> ATM driver?
>
> It is obvious that different set-up should be applied for mpc8260 ATM driver
> MPHY
> mode anyway...
>
> Thank you for answers in advance.
>
> Regards,
> Zoran Stojsavljevic
> DKTS Pupin Telecom
>
> ----- Original Message -----
> From: "Gilad Rom" <gilad@romat.com>
> To: "Alex Zeffertt" <ajz@cambridgebroadband.com>
> Cc: <linux-atm-general@lists.sourceforge.net>;
> <linuxppc-embedded@lists.linuxppc.org>
> Sent: Monday, January 26, 2004 3:03 PM
> Subject: Re: [Linux-ATM-General] Announcement: MPHY now supported
> inmpc860sar
>
>
> > Okay. Thanks.
> >
> > And now for my next question - Do you think the driver
> > should run on the 82xx family of chips? (e.g. 8260 and the likes)
> > these guys have 2 Utopia-II ports with support for up to 31 devices
> > per port. Coupled with this software, it could make for a highly
> > efficient DSLAM.
> >
> > Gilad.
> >
> > ----- Original Message -----
> > From: "Alex Zeffertt" <ajz@cambridgebroadband.com>
> > To: "Gilad Rom" <gilad@romat.com>
> > Cc: <linux-atm-general@lists.sourceforge.net>;
> > <linuxppc-embedded@lists.linuxppc.org>
> > Sent: Monday, January 26, 2004 3:59 PM
> > Subject: Re: [Linux-ATM-General] Announcement: MPHY now supported
> > inmpc860sar
> >
> >
> > > It is currently only supported in SAR mode, and in that mode there is an
> > > upper limit of 4 UTOPIA phys.  However, there's no reason that support
> > > can't be added for MPHY in ESAR mode - in which the limit is 31 phys.  I
> > > suspect that adding such support would be easier now that Rodolfo has
> > > done most of the work.
> > >
> > > Alex
> > >
> > > PS I'm not the expert on this.  Rodolfo's sourceforge username is
> > > "zaigor".
> > >
> > > On Mon, 2004-01-26 at 13:51, Gilad Rom wrote:
> > > > This is very exciting news! (well, for me it is)
> > > >
> > > > How many PHY's in parallel are we talking about here?
> > > >
> > > > Thanks,
> > > > Gilad.
> > > >
> > > >
> > > > ----- Original Message -----
> > > > From: "Alex Zeffertt" <ajz@cambridgebroadband.com>
> > > > To: <linux-atm-general@lists.sourceforge.net>;
> > > > <linuxppc-embedded@lists.linuxppc.org>
> > > > Sent: Monday, January 26, 2004 1:41 PM
> > > > Subject: [Linux-ATM-General] Announcement: MPHY now supported in
> > mpc860sar
> > > >
> > > >
> > > > > Just a quick note to say that multi-phy is now supported by the
> > > > > mpc860sar ATM driver, thanks to a patch by Rodolfo Giometti.
> > > > >
> > > > > Page: http://sourceforge.net/projects/mpc860sar/
> > > > >
> > > > > Alex
> > > > >
> > > > >
> > > > >
> > > > >
> > >
> > >
> >
> >
> >
> >


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
