Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id AB240DDDA2
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 16:21:07 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 9so1756029ywe.39
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 22:21:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090331.221601.114102644.davem@davemloft.net>
References: <fa686aa40903311845v54ddfb91u56dd11eff64140d4@mail.gmail.com>
	<20090331.203855.96368726.davem@davemloft.net>
	<fa686aa40903312156m2aad029i7dc27700bc9418fb@mail.gmail.com>
	<20090331.221601.114102644.davem@davemloft.net>
Date: Tue, 31 Mar 2009 23:21:05 -0600
Message-ID: <fa686aa40903312221m30d351e3i56ebdbda079e6cd8@mail.gmail.com>
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

On Tue, Mar 31, 2009 at 11:16 PM, David Miller <davem@davemloft.net> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> Date: Tue, 31 Mar 2009 22:56:38 -0600
>
>> At the very least, please consider picking up patches 2 & 3. =A0They
>> address a real bug (unrelated to the MDIO rework), and only touch the
>> MPC5200 FEC driver.
>
> Please submit them seperately, and I will look them over.\

Will do.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
