Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 83F2DB7D92
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Apr 2010 19:51:40 +1000 (EST)
Message-ID: <4BC83304.3000501@embedded-sol.com>
Date: Fri, 16 Apr 2010 12:51:00 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@mvista.com>
Subject: Re: [PATCH] powerpc/85xx: Add eTSEC 2.0 support for P1020RDB boards
References: <20100415183631.GA25923@oksana.dev.rtsoft.ru>
In-Reply-To: <20100415183631.GA25923@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Aggrwal Poonam-B10812 <B10812@freescale.com>,
	Sandeep Gopalpet <sandeep.kumar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Anton,

On 4/15/2010 9:36 PM, Anton Vorontsov wrote:
> This patch adds support for eTSEC 2.0 as found in P1020.
> The changes include introduction of the group nodes for
> the etsec nodes.
>
> Signed-off-by: Sandeep Gopalpet<sandeep.kumar@freescale.com>
> Signed-off-by: Anton Vorontsov<avorontsov@mvista.com>
> ---
>
> This is based on
> http://www.bitshrine.org/gpp/kernel-2.6.32-rc3-P1020RDB-DTS-Support-for-eTSEC-2.0-v0.patch
> but revamped for the mainline's OF bindings.
>
>
>    

Thanks a lot, I appreciate your help.

Felix.
