Return-Path: <davidkwho@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.198])
	by ozlabs.org (Postfix) with ESMTP id 3620A67CA0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Jul 2005 05:03:46 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i4so1292807wra
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Jul 2005 12:03:44 -0700 (PDT)
Message-ID: <4dd15d18050719120376b1a87c@mail.gmail.com>
Date: Tue, 19 Jul 2005 15:03:11 -0400
From: David Ho <davidkwho@gmail.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20050719184241.78430352671@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4dd15d1805071905573ebcba61@mail.gmail.com>
	<20050719184241.78430352671@atlas.denx.de>
Cc: David Jander <david.jander@protonic.nl>, linuxppc-embedded@ozlabs.org
Subject: Re: How reliable is jffs2 really (denx cvs devel kernel)?
Reply-To: David Ho <davidkwho@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Wolfgang,

It must have be more than a year ago that I did this.   And I have not
done any testing with the latest devel kernel from your CVS so I am
not making any conclusion about the latest kernel.

Just trying to be helpful. =20

The mount time issue is fixed a long time ago, so your back port most
probably has this fix.

David

On 7/19/05, Wolfgang Denk <wd@denx.de> wrote:
> In message <4dd15d1805071905573ebcba61@mail.gmail.com> you wrote:
> >
> > I updated the JFFS2 portion of the Denx devel kernel with the latest
> > from CVS and it solved the initial mount time problem.  But it was a
> > while a ago when I did this.  Both the devel kernel and the CVS head
> > has changed quite a bit since then.
>=20
> I would rally appreciate if you mentioned which exact version of  the
> kernel you are talking about. "The Denx devel kernel" can be anything
> - either yesterday or 3 years old.
>=20
> At the moment our CVS tree contains a snapshot from MTD CVS of  March
> 13, 2005; yes, we did the necessary backport to the 2.4 kernel.
>=20
> Do you want to say that this version still  has  mount  time  issues?
> Please provide details!
>=20
>=20
> Best regards,
>=20
> Wolfgang Denk
>=20
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> The word "fit", as I understand it, means "appropriate to a purpose",
> and I would say the body of the Dean is supremely appropriate to  the
> purpose of sitting around all day and eating big heavy meals.
>                                  - Terry Pratchett, _Moving Pictures_
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
