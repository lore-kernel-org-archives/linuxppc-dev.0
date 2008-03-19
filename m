Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id 7EFC4DDE09
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 16:05:58 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so65626anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 22:05:57 -0700 (PDT)
Message-ID: <fa686aa40803182205n741c652ci1e1871707c5c3e13@mail.gmail.com>
Date: Tue, 18 Mar 2008 23:05:56 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] [RFC] Xilinx: Add generic configuration option to enable
	all xilinx drivers.
In-Reply-To: <20080319043205.12E1F11E0071@mail67-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080212213120.D51157F806B@mail176-sin.bigfish.com>
	<fa686aa40803182115k241050f0meafccc29b4ef16@mail.gmail.com>
	<20080319043205.12E1F11E0071@mail67-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 18, 2008 at 10:32 PM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
>
>
>
>
> Hmm... interesting points.  I guess my feeling was that XILINX_DRIVERS could
> be a more broadly configurable option, with some of these ideas in mind.
> Currently, it's hidden by default, but we could easily change this to be
> visible by default, or selected by a broader number of architectures.  I
> tend to think about them as a group: What if x86 *did* support the
> primitives needed by these drivers, then if the individual drivers depend on
> XILINX_DRIVERS, then the modification could be made in one spot.  By your
> suggestion, we would have to modify each one independantly.

Heh; it's not *that* many drivers and it's just Kconfig stuff which is
real easy to change.  My preference would be to eliminate
XILINX_DRIVERS entirely, but I'm not going to fight about it.  :-)

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
