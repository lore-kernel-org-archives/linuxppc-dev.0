Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9FD0667B3F
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 00:05:50 +1000 (EST)
In-Reply-To: <17516.20191.490360.852876@cargo.ozlabs.ibm.com>
References: <9FCDBA58F226D911B202000BDBAD4673062C0A97@zch01exm40.ap.freescale.net>
	<17516.20191.490360.852876@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <07A74973-B96C-4975-8B73-BB5F284755E4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH/2.6.17-rc4 1/10] Powerpc: Add general support for mpc7
	448h pc2 (Taiga) platform
Date: Thu, 18 May 2006 09:06:00 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Alexandre.Bounine@tundra.com,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 18, 2006, at 5:39 AM, Paul Mackerras wrote:

> Zang Roy-r61911 writes:
>
>> I can migrate my code to embedded6xx technically. In fact,
>> I can move it into anywhere in the arch/powerpc/platforms.
>> While for mpc7448hpc2(taiga) board, it is not a embedded
>> application board. It is a high performance server! It seems
>> odd to put code there :). What's your opinion?
>
> What sort of machine(s) is this board used in?  Or what machines will
> it be in?

Its a reference board from Freescale with a MPC7448 + TSI108.   
Similar in concept to sandpoint.

- kumar
