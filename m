Return-Path: <glikely@secretlab.ca>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by ozlabs.org (Postfix) with ESMTP id 8E30510C87D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 04:49:36 +1000 (EST)
Received: by pwi4 with SMTP id 4so318236pwi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Sep 2010 11:49:34 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Wed, 15 Sep 2010 12:49:32 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [PATCH 15/15] ppc/vio: ensure dma_coherent_mask is set
Message-ID: <20100915184932.GD4446@angua.secretlab.ca>
References: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
	<1284573958-8397-16-git-send-email-nacc@us.ibm.com>
	<AANLkTi=K+KudbVAqZGA9fXXWq-vXirh9SuSTEHSh=kgC@mail.gmail.com>
	<20100915184456.GC3683@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100915184456.GC3683@us.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 15, 2010 at 11:44:56AM -0700, Nishanth Aravamudan wrote:
> On 15.09.2010 [12:37:58 -0600], Grant Likely wrote:
> > On Wed, Sep 15, 2010 at 12:05 PM, Nishanth Aravamudan <nacc@us.ibm.com> wrote:
> > > Without this change drivers, such as ibmvscsi, fail to load with the
> > > previous change.
> > 
> > Shouldn't this patch be ordered before the previous change then to
> > preserve bisectability?
> 
> You are probably right. I wasn't sure if I should fold it in or keep it
> separate. I should have changed the order, though. Sorry about that!

It's such a small patch I would just fold it in.

> 
> > Also, patch descriptions should be explicit about what the "previous
> > change" refers to.  Once this is committed, git log may very well
> > insert other changes from other branches between this commit and
> > whatever "previous change" refers to.
> 
> Yep -- what's the best way to make the reference? By subject from the
> patch? Obviously I don't have the SHA1 with which the commit will go
> upstream.

By name should be good.  As long as a reader doesn't need background
information from your head to figure out why the change was made then
it should be okay.

g.
