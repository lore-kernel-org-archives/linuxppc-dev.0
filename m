Return-Path: <jwboyer@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.229])
	by ozlabs.org (Postfix) with ESMTP id 6689EDDE2B
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Mar 2008 01:11:54 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so3989023wxd.15
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 06:11:46 -0800 (PST)
Date: Fri, 29 Feb 2008 08:09:28 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [dtc] breaking out libfdt from dtc so other progs can use it
Message-ID: <20080229080928.7ed025bb@zod.rchland.ibm.com>
In-Reply-To: <Pine.LNX.4.64.0802290930020.25557@vixen.sonytel.be>
References: <1204141243.18831.12.camel@thinkpad.austin.ibm.com>
	<20080228014101.GA24330@localhost.localdomain>
	<1204216244.6676.13.camel@thinkpad.austin.ibm.com>
	<20080228125940.78f7f2b6@vader.jdub.homelinux.org>
	<Pine.LNX.4.64.0802290930020.25557@vixen.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 29 Feb 2008 09:35:48 +0100 (CET)
Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:

> On Thu, 28 Feb 2008, Josh Boyer wrote:
> > On Thu, 28 Feb 2008 10:30:44 -0600
> > Jerone Young <jyoung5@us.ibm.com> wrote:
> > > If it where broken out of dtc it would be easier to pickup and pull
> > > fixes from it. Even package it so programs can easily build it
> > > standalone.
> > 
> > That's akin to saying libcrypto should be broken out to be completely
> > standalone from openssl.  That doesn't make sense either.
> 
> Thanks, your openssl example triggered me posting this reply ;-)
> 
> I think people are confusing source and binary packages.
> 
> E.g. on Debian, the openssl source package is used to build 3 binary packages:
> openssl, libssl0.9.8, and libssl-dev. Hence to install applications that use
> libssl, you don't have to install all 3, just libssl0.9.8.
> 
> But this doesn't mean libssl is separate from openssl source-wise: both are
> build from the same source package.
> 
> So the single source package dtc could be packaged as 2 binary packages: dtc
> and libfdt.

Yes, that's certainly possible for the various distros.  For Fedora
we'd have to get an exception for a static library, or convert it to a
shared one.  Other distros might not have that restriction.

josh
