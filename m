Return-Path: <glikely@secretlab.ca>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id CF982DDF64
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Aug 2007 00:21:21 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so30514uge
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Aug 2007 07:21:19 -0700 (PDT)
Message-ID: <fa686aa40708270721v1b5a984ci4fb8dd37c3b46299@mail.gmail.com>
Date: Mon, 27 Aug 2007 08:21:16 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: schardt <g.schardt@fz-juelich.de>
Subject: Re: Newbie and linux on virtex-II ppc
In-Reply-To: <46D2DCFC.40401@fz-juelich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <46D2C9A5.9030708@fz-juelich.de>
	<fa686aa40708270609x453092eye6eaf83b65ac2dee@mail.gmail.com>
	<46D2DCFC.40401@fz-juelich.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/27/07, schardt <g.schardt@fz-juelich.de> wrote:

> > Don't modify xparams by hand; it's not worth the trouble.  Go into
> > software setting in your EDK project and select 'linux-2.6' as the OS.
> >  Generate the libraries and copy the generated xparameters_ml40x.h
> > into your kernel tree.
> >
> >
> i dont have this option. do i need a update  ?

Probably, but you can use the montavista 2.4 option also.  You're only
interested in the xparameters.h file, not the whole BSP.  (Letting EDK
generate files into your kernel tree is scary)

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
