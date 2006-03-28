Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D7E06679F4
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Mar 2006 11:17:31 +1100 (EST)
In-Reply-To: <17448.26428.269343.872893@cargo.ozlabs.ibm.com>
References: <17443.49609.63829.380622@cargo.ozlabs.ibm.com>
	<0ED6B216-1F6E-40E7-9EB8-399F4066E273@kernel.crashing.org>
	<17448.26428.269343.872893@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1CA90A35-DBAF-4E33-8B45-33B36D885003@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Unify the 32 and 64 bit idle loops
Date: Mon, 27 Mar 2006 18:17:29 -0600
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 27, 2006, at 4:29 PM, Paul Mackerras wrote:

> Kumar Gala writes:
>
>> I'm now seeing the following kernel panic on an 83xx system (603
>> core) w/preempt on (2.6.16 is ok on this system):
>
> My mistake.  I just pushed a fix.

Thanks, that works better.

- kumar
