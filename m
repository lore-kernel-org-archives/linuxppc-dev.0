Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id CD153DE085
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 01:04:27 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so462190anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Apr 2008 08:04:25 -0700 (PDT)
Message-ID: <fa686aa40804140804q6950b206sd7dc5475b348e618@mail.gmail.com>
Date: Mon, 14 Apr 2008 09:04:24 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 2/2] [POWERPC] UCC nodes cleanup
In-Reply-To: <20080411170657.GA15270@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080311171045.GB4684@localhost.localdomain>
	<82E8E38A-C159-4C23-BDE8-086D4429F366@kernel.crashing.org>
	<20080411160654.GA25506@polina.dev.rtsoft.ru>
	<47FF9665.7020403@freescale.com>
	<20080411170657.GA15270@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jgarzik@pobox.com>,
	Timur Tabi <timur@freescale.com>, linux-serial@vger.kernel.org,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 11, 2008 at 11:06 AM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Fri, Apr 11, 2008 at 11:48:37AM -0500, Timur Tabi wrote:
>  > Anton Vorontsov wrote:
>  > > On Fri, Apr 11, 2008 at 09:13:36AM -0500, Kumar Gala wrote:
>  > >> On Mar 11, 2008, at 12:10 PM, Anton Vorontsov wrote:
>  > >>> - get rid of `model = "UCC"' in the ucc nodes
>  > >>>  It isn't used anywhere, so remove it. If we'll ever need something
>  > >>>  like this, we'll use compatible property instead.
>  > >>> - replace cell-index and device-id properties by fsl,ucc.
>  > >>>
>  > >>> Drivers are modified for backward compatibility's sake.
>  > >> I'd prefer we use cell-index and not introduce "fsl,ucc".  I'm ok with
>  > >> dropping device-id and model (its implied in the compatiable).
>  > >
>  > > Ok. Here it is. netdev and linux-serial Cc'ed.
>  >
>  > Do we want the first UCC to have a cell-index of 1?  Maybe we should fix this
>  > off-by-one error once and for all, and number all UCCs from 0?
>
>  Isn't documentation numbers UCC from 1? Then I believe we should stick
>  with it for device tree, since off by one is Linux implementation details.

Plus making such a change will break deployed device trees.

g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
