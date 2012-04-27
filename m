Return-Path: <bp@amd64.org>
Received: from mail.x86-64.org (s15943758.onlinehome-server.info
 [217.160.130.188]) by ozlabs.org (Postfix) with ESMTP id BE7FCB6F6E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Apr 2012 01:12:41 +1000 (EST)
Date: Fri, 27 Apr 2012 17:12:30 +0200
From: Borislav Petkov <bp@amd64.org>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH EDACv16 1/2] edac: Change internal representation to work
 with layers
Message-ID: <20120427151230.GB18798@aftab.osrc.amd.com>
References: <1335289087-11337-1-git-send-email-mchehab@redhat.com>
 <1335291342-14922-1-git-send-email-mchehab@redhat.com>
 <20120427133304.GE9626@aftab.osrc.amd.com>
 <1335535895.25521.7.camel@joe2Laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335535895.25521.7.camel@joe2Laptop>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>,
 Jason Uhlenkott <juhlenko@akamai.com>, Aristeu Rozanski <arozansk@redhat.com>,
 Hitoshi Mitake <h.mitake@gmail.com>, Shaohui Xie <Shaohui.Xie@freescale.com>,
 Mark Gross <mark.gross@intel.com>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 Ranganathan Desikan <ravi@jetztechnologies.com>,
 Borislav Petkov <bp@amd64.org>, Egor Martovetsky <egor@pasemi.com>,
 Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ericsson.com>,
 Tim Small <tim@buttersideup.com>, "Arvind R." <arvino55@gmail.com>,
 Chris Metcalf <cmetcalf@tilera.com>, Doug Thompson <norsk5@yahoo.com>,
 Linux Edac Mailing List <linux-edac@vger.kernel.org>,
 Michal Marek <mmarek@suse.cz>, Jiri Kosina <jkosina@suse.cz>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Olof Johansson <olof@lixom.net>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 27, 2012 at 10:11:35AM -0400, Joe Perches wrote:
> > > -extern struct mem_ctl_info *edac_mc_alloc(unsigned sz_pvt, unsigned nr_csrows,
> > > -					  unsigned nr_chans, int edac_index);
> > > +struct mem_ctl_info *edac_mc_alloc(unsigned sz_pvt, unsigned nr_csrows,
> > > +				   unsigned nr_chans, int edac_index);
> > 
> > Why not "extern"?
> 
> Using extern function prototypes in .h files
> isn't generally necessary nor is extern the
> more common kernel style.

Searching for it, there's this discussion, for example:
http://gcc.gnu.org/ml/gcc/2009-04/msg00812.html

Maybe we should put a small note in Documentation/CodingStyle what the
kernel preference is and hold people to it.

-- 
Regards/Gruss,
Boris.

Advanced Micro Devices GmbH
Einsteinring 24, 85609 Dornach
GM: Alberto Bozzo
Reg: Dornach, Landkreis Muenchen
HRB Nr. 43632 WEEE Registernr: 129 19551
