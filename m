Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from SG2EHSOBE005.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id 3C6B4DEBE8
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 01:50:16 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: 4xx support in arch/ppc is going away Real Soon Now
Date: Thu, 5 Jun 2008 08:48:03 -0700
In-Reply-To: <20080605101838.5b1d9233@zod.rchland.ibm.com>
References: <20080605095253.7df9dbe0@zod.rchland.ibm.com><fa686aa40806050811t4ab2fbfk9eed34d0972376c4@mail.gmail.com>
	<20080605101838.5b1d9233@zod.rchland.ibm.com>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>,
	"Grant Likely" <grant.likely@secretlab.ca>
Message-ID: <20080605154839.B87C5838078@mail206-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-dev-bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-dev-
> bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org] On Behalf Of Josh
Boyer
> Sent: Thursday, June 05, 2008 8:19 AM
> To: Grant Likely
> Cc: linuxppc-dev@ozlabs.org; Paul Mackerras
> Subject: Re: 4xx support in arch/ppc is going away Real Soon Now
> =

> On Thu, 5 Jun 2008 09:11:48 -0600
> "Grant Likely" <grant.likely@secretlab.ca> wrote:
> =

> > On Thu, Jun 5, 2008 at 8:52 AM, Josh Boyer
<jwboyer@linux.vnet.ibm.com> wrote:
> > > This commit (patch omitted due to size) is sitting in my local
tree:
> > >
> > > commit 0d7efc1e80fc262bcc507a605482c5681e3f082a
> > > Author: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> > > Date:   Thu Jun 5 09:46:17 2008 -0500
> > >
> > >    ppc/4xx: Remove 4xx support from arch/ppc
> > >
> > >    Remove support for PPC 403, 405, and 440 processors from
arch/ppc.  The
> > >    arch/powerpc equivalents should be used.  Boards that are not
ported yet
> > >    will need to be ported to arch/powerpc to have continued
support.
> >
> > This looks like unneeded churn.
> =

> Excellent.  My prompting has succeeded.  Though now I won't get to be
> on top of the "top contributors" list in the lwn.net pages like Kumar
> was.  Oh well.
> =

> > Paulus, Can we just kill all of arch/ppc for .27 right now?
> =

> Please.  Pretty please?
> =

> Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> =

> josh

For what it's worth, =


Acked-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

I'd like to see this happen soon so a few stacked patches we have can
finally go in.

Steve


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
