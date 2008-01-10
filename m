Return-Path: <linasvepstas@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id E3977DDF58
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 13:47:58 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so110688anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jan 2008 18:47:57 -0800 (PST)
Message-ID: <3ae3aa420801091847l189df8dwb2348624f0267af@mail.gmail.com>
Date: Wed, 9 Jan 2008 20:47:57 -0600
From: "Linas Vepstas" <linasvepstas@gmail.com>
To: michael@ellerman.id.au
Subject: Re: [PATCH 1/8] pseries: phyp dump: Docmentation
In-Reply-To: <1199919545.7880.11.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4782B985.2090508@austin.ibm.com> <4782C026.8080302@austin.ibm.com>
	<20080109042911.GT14201@localdomain>
	<3ae3aa420801090731r2e25e42awcae385b448e20b16@mail.gmail.com>
	<20080109184437.GU14201@localdomain>
	<1199919545.7880.11.camel@concordia>
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, lkessler@us.ibm.com,
	Nathan Lynch <ntl@pobox.com>, strosake@us.ibm.com
Reply-To: linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 09/01/2008, Michael Ellerman <michael@ellerman.id.au> wrote:
>
> > > Only if you can get at rtas, but you can't get at rtas at that point.
>
> AFAICT you don't need to get at RTAS, you just need to look at the
> device tree to see if the property is present, and that is trivial.
>
> You probably just need to add a check in early_init_dt_scan_rtas() which
> sets a flag for the PHYP dump stuff, or add your own scan routine if you
> need.

I no longer remember the details. I do remember spending a lot of time
trying to figure out how to do this. I know I didn't want to write my own scan
routine; maybe that's what stopped me.  As it happens, we also did most
of the development on a broken phyp which simply did not even have
this property, no matter what, and so that may have brain-damaged me.

I went for the "most elegant" solution, where "most elegant" is defined
as "fewest lines of code", "least effort", etc.

Manish may need some hands-on help to extract this token during
early boot.  Hopefully, he'll let us know.

--linas
