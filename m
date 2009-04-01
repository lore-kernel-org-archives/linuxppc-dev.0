Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f157.google.com (mail-gx0-f157.google.com
	[209.85.217.157]) by ozlabs.org (Postfix) with ESMTP id 8CDEADDE06
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 15:56:40 +1100 (EST)
Received: by gxk1 with SMTP id 1so10475792gxk.9
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 21:56:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090331.203855.96368726.davem@davemloft.net>
References: <fa686aa40903311519m3108c697v52180d192975a3b1@mail.gmail.com>
	<20090331.152237.210090951.davem@davemloft.net>
	<fa686aa40903311845v54ddfb91u56dd11eff64140d4@mail.gmail.com>
	<20090331.203855.96368726.davem@davemloft.net>
Date: Tue, 31 Mar 2009 22:56:38 -0600
Message-ID: <fa686aa40903312156m2aad029i7dc27700bc9418fb@mail.gmail.com>
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

On Tue, Mar 31, 2009 at 9:38 PM, David Miller <davem@davemloft.net> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> Date: Tue, 31 Mar 2009 19:45:02 -0600
>
>> Dammit. =A0Why did you have to go and sound so reasonable when I was all
>> geared up for a pointless flame war.
>>
>> well... alright... but I reserve the right to be grumpy and surly for
>> a few days.
>
> :-)
>
> Just in case you decided to continue, I did cover my ass by
> making an explicit posting explaining the policy and the
> intent on netdev last week:
>
> http://marc.info/?l=3Dlinux-netdev&m=3D123814105015481&w=3D2

At the very least, please consider picking up patches 2 & 3.  They
address a real bug (unrelated to the MDIO rework), and only touch the
MPC5200 FEC driver.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
