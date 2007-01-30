Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [RFC, PATCH 4/4] Add support to OProfile for
	profiling Cell BE SPUs -- update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200701300839.05144.arnd@arndb.de>
References: <45BE4ED0.5030808@us.ibm.com> <45BE4FA4.9020105@us.ibm.com>
	<200701300839.05144.arnd@arndb.de>
Content-Type: text/plain
Date: Tue, 30 Jan 2007 18:53:50 +1100
Message-Id: <1170143630.26655.326.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > +/* Defines used for sync_start */
> > +#define SKIP_GENERIC_SYNC 0
> > +#define SYNC_START_ERROR -1
> > +#define DO_GENERIC_SYNC 1
> > +
> > +typedef struct vma_map
> > +{
> > +       struct vma_map *next;
> > +       unsigned int vma;
> > +       unsigned int size;
> > +       unsigned int offset;
> > +       unsigned int guard_ptr;
> > +       unsigned int guard_val;
> > +} vma_map_t;

I haven't had time to look in details yet but in that context, what does
"vma" stands for ? There's already an important vm data structure in
linux routinely called "vma" and thus I suspect this is a poor naming
choice as it will cause confusion.

Cheers,
Ben.
