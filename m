Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by ozlabs.org (Postfix) with ESMTP id 0E3B7DDFB5
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Aug 2008 22:28:26 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so434063pyi.27
	for <linuxppc-dev@ozlabs.org>; Fri, 01 Aug 2008 05:28:25 -0700 (PDT)
Subject: Re: Board level compatibility matching
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
In-Reply-To: <20080801080632.35edcb04@zod.rchland.ibm.com>
References: <fa686aa40807311319k44d270b0t4fa9cb0e6523339@mail.gmail.com>
	<20080801025439.GB5008@yookeroo.seuss>
	<20080801032533.GB6595@secretlab.ca>
	<1217564739.11188.482.camel@pasglop>
	<20080801080632.35edcb04@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Fri, 01 Aug 2008 08:28:21 -0400
Message-Id: <1217593701.2328.6.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, devicetree-discuss@ozlabs.org
Reply-To: jwboyer@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-08-01 at 08:06 -0400, Josh Boyer wrote:
> On Fri, 01 Aug 2008 14:25:39 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > About this whole generic board mumbo-jumbo: not happening. It's a pipe
> > dream, it doesn't work, and it leads to the sort of mess we have in chrp
> > where we end up having hacks to identify what exact sort of chrp we have
> > and do things differently etc...
> > 
> > NOT HAPPENING.
> > 
> > Now, there are two approaches here that are possible:
> > 
> >  - Your board is really pretty much exactly the same as board XXX,
> > except maybe you have a different flash size or such, and the support
> > for board XXX can cope perfectly with it simply due to the device-tree
> > the right information.
> > 
> > If that happens to be the case, make your board compatible with board
> > XXX. Make that entry -second- in your compatible list, because one day
> > you'll figure out that there -is- indeed a difference and I don't want
> > to see board XXX code start to grow code to recognise your other board
> > and work around the difference. So at that stage, copy board XXX.c file
> > and start over with your own board support that matches on your first
> > compatible propery entry.
> 
> 44x does this today for a small number of boards.  The "issue", if
> there really is one, is that there's no clear definition on what is
> acceptable to be called "compatible".  If _Linux_ platform support for
> board FOO

Ignore that last line.  Emailing before coffee is considered dangerous.

josh
