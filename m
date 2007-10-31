Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.179])
	by ozlabs.org (Postfix) with ESMTP id B6E9DDE122
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 13:09:26 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id a29so4424943pyi
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 19:09:25 -0700 (PDT)
Date: Tue, 30 Oct 2007 21:09:17 -0500
From: Josh Boyer <jwboyer@gmail.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/4] PowerPC: 440GRx Rainier DTS.
Message-ID: <20071030210917.42cfb88b@vader.jdub.homelinux.org>
In-Reply-To: <20071031015651.GB19318@lixom.net>
References: <20071030164511.GA21973@ru.mvista.com>
	<20071030165650.GA22107@ru.mvista.com>
	<20071030230805.GC2784@localhost.localdomain>
	<20071031015651.GB19318@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 30 Oct 2007 20:56:51 -0500
Olof Johansson <olof@lixom.net> wrote:

> On Wed, Oct 31, 2007 at 10:08:05AM +1100, David Gibson wrote:
> > On Tue, Oct 30, 2007 at 07:56:50PM +0300, Valentine Barshak wrote:
> > > PowerPC 440GRx Rainier DTS.
> > [snip]
> > > +		SDRAM0: sdram {
> > > +			device_type = "memory-controller";
> > 
> > How many times do we need to say it...
> > 
> > Don't make up random device_type values.  This does not belong here.
> 
> Maybe there should be something like checkpatch.pl that warns about
> these kinds of things so people can check for it without getting flamed
> first. :-)

That's actually a decent idea.  We could even have this thing that
takes DTS files and processes them...  oh wait.

So why can't we make a whitelist of "allowed" device_types in DTC and
make it whine about anything outside of that?

josh
