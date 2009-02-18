Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5CDF0DDD0C
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 04:04:57 +1100 (EST)
Message-Id: <F122E3A2-3054-4BC9-9C06-0ADE590A8AFC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Coulter <scott.coulter@cyclone.com>
In-Reply-To: <43EB80E07C42E1408726E4905FB96B04C0769D@CYBORG3.cyclone.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: Gianfar tx-babbling-errors
Date: Wed, 18 Feb 2009 11:03:34 -0600
References: <43EB80E07C42E1408726E4905FB96B04C0769D@CYBORG3.cyclone.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 18, 2009, at 10:16 AM, Scott Coulter wrote:

>
> Hi all,
>
> As a simple stress test for my board with an MPC8572E and an  
> MPC8568E on
> it, I setup both processors to boot linux 2.6.27.6 with an NFS root  
> and
> then perform repeated native compiles of a linux kernel over NFS.   
> After
> running for 4 days straight or so with between 250-300 build cycles  
> per
> processor, I stopped the builds and ran ethtool to look for any odd
> statistics.  Both processors reported non-zero values for
> tx-babbling-errors.  Both processors reported around 1300
> tx-babbling-errors out of about 80,000,000 Tx packets.  Should I be
> concerned about the tx-babbling-errors?  What conditions would cause
> these errors to be reported?
>
> Thanks,
> Scott

I'm told this will occur when:

Transmitted frame > MAXFRM and MACCFG2[Huge En] = 0.

- k
