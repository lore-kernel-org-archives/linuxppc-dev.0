Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 36882DDDD8
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Jul 2008 18:10:53 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Need stable 2.6 kernel for TQM823L
Date: Fri, 4 Jul 2008 10:10:48 +0200
References: <200807021418.13596.tmaenner@aehr.com>
	<20080703190440.GA3098@secretlab.ca>
	<200807031839.19123.tmaenner@aehr.com>
In-Reply-To: <200807031839.19123.tmaenner@aehr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807041010.48740.sr@denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Tom,

On Friday 04 July 2008, Thomas Maenner wrote:
> > arch/ppc is depreciated and will disappear in 2.6.27.  I don't know if
> > anyone is actively keeping 8xx support working in arch/ppc so you may
> > experience significant breakage.
> >
> > g.
>
> Not exactly what I was hoping to hear...
>
> What are the reasons to not port these TQs to 2.6?
> Lack of resources? Not enough interest?

We (DENX) have been maintaining those TQM8xx boards (U-Boot & Linux). But till 
now nobody asked us to port these over to arch/powerpc. You may understand 
that we won't do this "just for fun". If you are interested in an 
arch/powerpc port for these boards, we could do this of course. Please 
contact me off list if you are interested in such a project.

Thanks.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
