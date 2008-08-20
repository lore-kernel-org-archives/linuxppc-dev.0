Return-Path: <jwboyer@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id 4F32CDE8A8
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 00:46:12 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so118088anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 07:46:10 -0700 (PDT)
Subject: Re: [PATCH 1/9] powerpc/44x: Add PowerPC 44x simple platform support
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40808200715x6c850593p5655d8b5b8e7b61e@mail.gmail.com>
References: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
	<496103659f7b122a8301703b055ef4c6bd3092af.1219160188.git.jwboyer@linux.vnet.ibm.com>
	<200808201533.22258.arnd@arndb.de>
	<fa686aa40808200715x6c850593p5655d8b5b8e7b61e@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 20 Aug 2008 10:45:47 -0400
Message-Id: <1219243548.26429.25.camel@jdub.homelinux.org>
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
Reply-To: jwboyer@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-08-20 at 08:15 -0600, Grant Likely wrote:
> On Wed, Aug 20, 2008 at 7:33 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 19 August 2008, Josh Boyer wrote:
> >> This adds a common board file for almost all of the "simple" PowerPC 44x
> >> boards that exist today.  This is intended to be a single place to add
> >> support for boards that do not differ in platform support from most of the
> >> evaluation boards that are used as reference platforms.  Boards that have
> >> specific requirements or custom hardware setup should still have their own
> >> board.c file.
> >
> > The code looks correct, but since this is going to be example code
> > that may get copied into other platforms, I would take extra care
> > for coding style:
> 
> I second Arnd's comments.  Otherwise, this looks pretty good to me.

You should fix 52xx with the same for loop change then, since I
blatantly most of this file from you ;)

josh
