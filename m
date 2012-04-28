Return-Path: <joe@perches.com>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
 (using SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CC836B6FE9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Apr 2012 06:38:44 +1000 (EST)
Message-ID: <1335645521.4191.13.camel@joe2Laptop>
Subject: Re: [PATCH EDACv16 1/2] edac: Change internal representation to
 work with layers
From: Joe Perches <joe@perches.com>
To: Borislav Petkov <bp@amd64.org>
Date: Sat, 28 Apr 2012 13:38:41 -0700
In-Reply-To: <20120428085223.GB26065@aftab.osrc.amd.com>
References: <1335289087-11337-1-git-send-email-mchehab@redhat.com>
 <1335291342-14922-1-git-send-email-mchehab@redhat.com>
 <20120427133304.GE9626@aftab.osrc.amd.com>
 <1335535895.25521.7.camel@joe2Laptop> <4F9AC44A.5000509@redhat.com>
 <20120428085223.GB26065@aftab.osrc.amd.com>
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

On Sat, 2012-04-28 at 10:52 +0200, Borislav Petkov wrote:
> On Fri, Apr 27, 2012 at 01:07:38PM -0300, Mauro Carvalho Chehab wrote:
> > Yes. This is a common issue at the EDAC core: on several places, it calls the
> > edac debug macros (DEBUGF0...DEBUGF4) passing a __func__ as an argument, while
> > the debug macros already handles that. I suspect that, in the past, the __func__
> > were not at the macros, but some patch added it there, and forgot to fix the
> > occurrences of its call.
> 
> The patch that added it is d357cbb445208 and you reviewed it.
> 
> > This is something that needs to be reviewed at the entire EDAC core (and likely
> > at the drivers).
> 
> Looks like a job for a newbie to get her/his feet wet with kernel work.

Looks to me more like a lazy maintainer/developer who doesn't
want to bother with a few minutes work.
