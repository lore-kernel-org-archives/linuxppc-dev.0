Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 552DCDE1C2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Jan 2008 04:47:01 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0SHkwNK005994
	for <linuxppc-embedded@ozlabs.org>; Mon, 28 Jan 2008 12:46:58 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0SHkxvc179730
	for <linuxppc-embedded@ozlabs.org>; Mon, 28 Jan 2008 12:46:59 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0SHkw58025951
	for <linuxppc-embedded@ozlabs.org>; Mon, 28 Jan 2008 12:46:58 -0500
Date: Mon, 28 Jan 2008 11:45:59 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Erickson <gerickson@nuovations.com>
Subject: Re: Preferred GIT URL for arch/powerpc Latest-and-Greatest (was Re:
	Reminder: removal of arch/ppc - (Sequoia))
Message-ID: <20080128114559.5502b42f@zod.rchland.ibm.com>
In-Reply-To: <C3C34A58.D10E%gerickson@nuovations.com>
References: <20080127200044.148982a6@zod.rchland.ibm.com>
	<C3C34A58.D10E%gerickson@nuovations.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 28 Jan 2008 09:01:12 -0800
Grant Erickson <gerickson@nuovations.com> wrote:

> On 1/27/08 6:00 PM, Josh Boyer wrote:
> > On Sun, 27 Jan 2008 18:37:22 -0500
> > Steve Heflin <sheflin@newagemicro.com> wrote:
> > 
> >> Hello!
> >> 
> >> Yes! I'm looking at 2.6.23.14 as I thought that was the newest
> >> version. I completely missed seeing the 2.6.24 kit, thank you so much!!
> > 
> > FYI, 2.6.24 is considered fairly old relatively speaking.  With so much
> > activity going on for the embedded boards for arch/powerpc, you're sort
> > of missing out if you aren't running from the latest git trees.
> > 
> > Yes, I realize how ridiculous it sounds to say a kernel that was just
> > released 3 days ago is old, but that's reality.
> > 
> > josh
> 
> What's the best/preferred GIT URL for current, up-to-date arch/powerpc
> activity? Is it?
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc

Yep, that's the canonical source.

> I am particularly interested in Kilauea/Haleakala-related development.

My tree:

git://git.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git 

might briefly have some stuff for those that Paul's doesn't at times,
but as of right now they are synced up.  Typically there are only
changes on the next kernel branch during the development period for
that particular version.

josh
