Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DE048B7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Sep 2009 13:09:12 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1EBB5DDDD3
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Sep 2009 13:09:09 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: Fix SMP compile error and allow NULL for
	smp_ops
Mime-Version: 1.0 (Apple Message framework v1075.2)
Content-Type: text/plain; charset=us-ascii; format=flowed
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1252445472.4950.96.camel@pasglop>
Date: Tue, 8 Sep 2009 22:08:57 -0500
Message-Id: <067E4FF3-3DF9-462B-A090-2D989E710276@kernel.crashing.org>
References: <1252437668-28508-1-git-send-email-galak@kernel.crashing.org>
	<1252445472.4950.96.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 8, 2009, at 4:31 PM, Benjamin Herrenschmidt wrote:

> On Tue, 2009-09-08 at 14:21 -0500, Kumar Gala wrote:
>
>>
>> struct smp_ops_t smp_85xx_ops = {
>> +	.message_pass = NULL,
>> +	.probe = NULL,
>> 	.kick_cpu = smp_85xx_kick_cpu,
>> +	.setup_cpu = NULL,
>> };
>
> Why explicitely setting those to NULL ?
>
> Cheers,
> Ben.

couldn't remember if we get NULL for initialized structs or not.

- k
