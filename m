Return-Path: <niklaus.giger@member.fsf.org>
Received: from viefep24-int.chello.at (viefep18-int.chello.at [213.46.255.22])
	by ozlabs.org (Postfix) with ESMTP id 702BCDE4EC
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Oct 2008 05:51:56 +1000 (EST)
From: Niklaus Giger <niklaus.giger@member.fsf.org>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] Added preliminary support for Netstal HCU4 board
Date: Thu, 2 Oct 2008 21:51:52 +0200
References: <200810011947.16543.niklaus.giger@member.fsf.org>
	<200810022108.44690.niklaus.giger@member.fsf.org>
	<1222976220.9242.16.camel@ld0161-tx32>
In-Reply-To: <1222976220.9242.16.camel@ld0161-tx32>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200810022151.53162.niklaus.giger@member.fsf.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Donnerstag 02 Oktober 2008 21.37:00 schrieb Jon Loeliger:
> On Thu, 2008-10-02 at 21:08 +0200, Niklaus Giger wrote:
> > > > convert-dtsv0 is a small utility program which converts (DTS)
> > > > Device Tree Source from the obsolete version 0 to version 1. Version
> > > > 1 DTS files are marked by line "/dts-v1/;" at the top of the file.
> > >
> > > Add this remark where, though?
> >
> > Add a small chapter IV Utilities in your Documentation/manual.txt.
>
> Patches welcome, of course. :-)
>
> > And if the http://www.jdl.com/git_repos/ would work again, I think the
> > spiders would pick it up from there.
>
> I fetched http://www.jdl.com/software/dtc.git through
> my firewall at work just this morning.  What problem
> are you seeing?  Are you unable to clone
> git://git.jdl.com/software/dtc/git ?
>
> jdl
git pull worked perfectly. But in Documentation/manual.txt you promise:
> -- The gitweb interface is:
>
>     http://www.jdl.com/git_repos/
And this link does not work.

Best regards.

Niklaus
