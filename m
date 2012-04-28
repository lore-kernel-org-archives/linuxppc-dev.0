Return-Path: <joe@perches.com>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
 (using SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 05012B6FDA
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Apr 2012 03:07:59 +1000 (EST)
Message-ID: <1335632874.4191.8.camel@joe2Laptop>
Subject: Re: [PATCH EDACv16 1/2] edac: Change internal representation to
 work with layers
From: Joe Perches <joe@perches.com>
To: Borislav Petkov <bp@amd64.org>
Date: Sat, 28 Apr 2012 13:07:54 -0400
In-Reply-To: <20120428091621.GE26065@aftab.osrc.amd.com>
References: <1335289087-11337-1-git-send-email-mchehab@redhat.com>
 <1335291342-14922-1-git-send-email-mchehab@redhat.com>
 <20120427133304.GE9626@aftab.osrc.amd.com> <4F9ADCE3.2030506@redhat.com>
 <20120428091621.GE26065@aftab.osrc.amd.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>,
 Jason Uhlenkott <juhlenko@akamai.com>, Aristeu Rozanski <arozansk@redhat.com>,
 Hitoshi Mitake <h.mitake@gmail.com>, Shaohui Xie <Shaohui.Xie@freescale.com>,
 Mark Gross <mark.gross@intel.com>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 Ranganathan Desikan <ravi@jetztechnologies.com>,
 Egor Martovetsky <egor@pasemi.com>,
 Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund@ericsson.com>,
 Tim Small <tim@buttersideup.com>, "Arvind R." <arvino55@gmail.com>,
 Chris Metcalf <cmetcalf@tilera.com>, Doug Thompson <norsk5@yahoo.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux Edac Mailing List <linux-edac@vger.kernel.org>,
 Michal Marek <mmarek@suse.cz>, Jiri Kosina <jkosina@suse.cz>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2012-04-28 at 11:16 +0200, Borislav Petkov wrote:
> On Fri, Apr 27, 2012 at 02:52:35PM -0300, Mauro Carvalho Chehab wrote:
> > > All those local variables should be sorted in a reverse christmas tree
> > > order:
> > > 
> > > 	u32 this_is_the_longest_array_name[LENGTH];
> > > 	void *shorter_named_variable;
> > > 	unsigned long size;
> > > 	int i;
> > > 
> > > 	...
> > 
> > Why? There's nothing at the CodingStyle saying about how the vars should
> > be ordered. If you want to enforce some particular order, please do it
> > yourself, but apply it consistently among the entire subsystem.
> 
> First of all, this way it is more readable.

Not in my opinion, and blindly using "reverse christmas tree"
can separate variables that should be declared together.
