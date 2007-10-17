Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.224])
	by ozlabs.org (Postfix) with ESMTP id DA550DDF21
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 06:31:18 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so1654103nzh
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 13:31:17 -0700 (PDT)
Message-ID: <fa686aa40710171331n6ddb4613xad166131c88427fc@mail.gmail.com>
Date: Wed, 17 Oct 2007 14:31:16 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Subject: Re: Merge dtc
In-Reply-To: <20071017151230.01ccd2f8@weaponx.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071016050217.GA9052@localhost.localdomain>
	<B17BEF48-34FC-44E0-AC23-1DB7522EB198@kernel.crashing.org>
	<18196.20112.728499.256646@cargo.ozlabs.ibm.com>
	<5E3B6FCC-5930-4C76-AB4B-86B35551B9E0@kernel.crashing.org>
	<47166988.3010606@freescale.com>
	<20071017151230.01ccd2f8@weaponx.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Mackerras <paulus@samba.org>,
	Timur Tabi <timur@freescale.com>, Paul@ozlabs.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/17/07, Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> On Wed, 17 Oct 2007 14:59:04 -0500
> Timur Tabi <timur@freescale.com> wrote:
>
> > Kumar Gala wrote:
> >
> > > Just out of interest who's complaining?  We don't include mkimage for
> > > u-boot related builds and I haven't seen any gripes related to that.
> >
> > I think we should include mkimage *and* dtc.  But then, I'm not sure how much
> > weight my opinion has. :-)
>
> Either way, if we're going to include DTC we need to do it soon.
> mkimage I'm less worried about because it should be a much smaller
> patch.

Cast my vote on the 'no' side.  I don't like this approach.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
