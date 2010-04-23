Return-Path: <osstklei@de.ibm.com>
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.17.166])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1DE07B7D1C
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Apr 2010 18:22:38 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.1/8.13.1) with ESMTP id o3N8MYuG007642
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Apr 2010 08:22:34 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id o3N8MYu61687598
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Apr 2010 10:22:34 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id o3N8MXrH023553
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Apr 2010 10:22:33 +0200
Message-ID: <4BD158C9.90807@de.ibm.com>
Date: Fri, 23 Apr 2010 10:22:33 +0200
From: Thomas Klein <osstklei@de.ibm.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/2][RESEND] ehea: error handling improvement
References: <201004211110.55986.tklein@de.ibm.com>
	<20100421.223620.257172362.davem@davemloft.net>
In-Reply-To: <20100421.223620.257172362.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: tklein@de.ibm.com, netdev@vger.kernel.org, themann@de.ibm.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/22/2010 07:36 AM, David Miller wrote:
> From: Thomas Klein<tklein@de.ibm.com>
> Date: Wed, 21 Apr 2010 11:10:55 +0200
>
>> Reset a port's resources only if they're actually in an error state
>>
>> Signed-off-by: Thomas Klein<tklein@de.ibm.com>
>> ---
>>
>> Patch created against net-2.6
>
> I thought you were sorry for wasting my time and that you were going
> to follow the directions I gave you last time, and I quote:
>
> --------------------
> 3) These are not appropriate for net-2.6 as we are deep in
>     the -rcX series at this point and only the most diabolical
>     bug fixes are appropriate.  Therefore, please generate these
>     against net-next-2.6, thanks.
> --------------------
>
> And here you are generating your patches against net-2.6.  Heck, you
> even feel it's worth mentioning explicitly.

Guilty! Allows no excuse. Screwed it. Deeply sorry.

>
> Lucky for you the patches happen to apply cleanly to net-next-2.6 so
> I've put them there.

Thanks!
Thomas

> --
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
