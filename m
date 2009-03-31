Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id DACFEDDE07
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 09:19:43 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 9so1657278ywe.39
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 15:19:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090331.145738.36845509.davem@davemloft.net>
References: <20090331075537.1427.7819.stgit@localhost.localdomain>
	<20090331.145738.36845509.davem@davemloft.net>
Date: Tue, 31 Mar 2009 16:19:42 -0600
Message-ID: <fa686aa40903311519m3108c697v52180d192975a3b1@mail.gmail.com>
Subject: Re: [PATCH 00/14] Add common OF device tree support for MDIO busses
From: Grant Likely <grant.likely@secretlab.ca>
To: David Miller <davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Joakim.Tjernlund@transmode.se, netdev@vger.kernel.org,
	linuxppc-dev@ozlabs.org, afleming@freescale.com, olof@lixom.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 31, 2009 at 3:57 PM, David Miller <davem@davemloft.net> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> Date: Tue, 31 Mar 2009 02:26:43 -0600
>
>> David, as I mentioned below, I'd really like to get the core changes
>> (1, 4, 5 =A06) merged into 2.6.30 (assuming Andy confirms they are okay)=
.
>
> No, sorry.
>
> We could have worked out the interdependencies before the merge window
> openned up. =A0There is no reason this could not have sat in at least
> somebody's tree before the merge window started.

It's been out there on the list since before the merge window, getting
tested by more than just me.  This is not series which has simply
dropped out of thin air.  I've been working hard to address issues
reported by others (Thanks Olof!) and to keep it building and applying
cleanly to the top of tree.

> It therefore didn't get any -next exposure, so it's unreasonable to
> merge this stuff now.

Since when has sitting in a -next tree been a requirement for merging
when the series has been kept up to date and tested?  I purposefully
kept it out of -next to ensure that when it was applied for real to a
-next tree it would be as complete, bug free, and bisectable as
possible since once it hits a signed-off -next branch the individual
commit cannot be modified.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
