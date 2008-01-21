Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id 34BF1DDE45
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 07:53:35 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so509027anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jan 2008 12:53:34 -0800 (PST)
Message-ID: <fa686aa40801211253l149e96aaj1d915652b4eee500@mail.gmail.com>
Date: Mon, 21 Jan 2008 13:53:34 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: [patch v4 0/4] Cypress c67x00 (EZ-Host/EZ-OTG) support
In-Reply-To: <200801211251.02288.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080121103434.397382000@sunsite.dk>
	<fa686aa40801210911q4ce90816tebafa46e68a3f980@mail.gmail.com>
	<87zluz0w9g.fsf@macbook.be.48ers.dk>
	<200801211251.02288.david-b@pacbell.net>
Cc: linux-usb@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/21/08, David Brownell <david-b@pacbell.net> wrote:
> On Monday 21 January 2008, Peter Korsgaard wrote:
> > Sure, http://peter.korsgaard.com/c67x00-v3-v4.patch (not posting as
> > it's more than 100k)
>
> I like this bit:
>
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3832,6 +3832,12 @@ L:      linux-usb@vger.kernel.org
> >  S:     Maintained
> >  W:     http://www.kroah.com/linux-usb/
> >
> > +USB CYPRESS C67X00 DRIVER
> > +P:     Peter Korsgaard
> > +M:     jacmet@sunsite.dk
> > +L:     linux-usb@vger.kernel.org
> > +S:     Maintained
> > +
> >  USB DAVICOM DM9601 DRIVER
> >  P:     Peter Korsgaard
> >  M:     jacmet@sunsite.dk
>
> :)
>
> Grant, please let us know if you see anything to object to in
> this "v4" patch (parts 1..3 only).  At a quick glance, I didn't
> see any ... other than stuff associated with peripheral mode
> support, which isn't yet proposed for merging.  So for the
> moment it looks like v4 is the one to review (and maybe merge).

np.  Hopefully in the next day or so I'll get to spend some quality
time with this diff.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
