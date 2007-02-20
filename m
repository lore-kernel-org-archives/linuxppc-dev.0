Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 25256DDD0D
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 00:50:31 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1KDoRfM005173
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 08:50:27 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1KDoRhD538580
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 06:50:27 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1KDoQF2012623
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 06:50:27 -0700
Subject: Re: [PATCH 13/14] Re-organize Kconfig code for 4xx in arch/powerpc
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070220021236.3609EDDD0A@ozlabs.org>
References: <20070220021236.3609EDDD0A@ozlabs.org>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 07:51:29 -0600
Message-Id: <1171979489.24204.62.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-02-20 at 13:12 +1100, David Gibson wrote:
> 
> -# It's often necessary to know the specific 4xx processor type.
> -# Fortunately, it is impled (so far) from the board type, so we
> -# don't need to ask more redundant questions.
> +# 40x specific CPU modules, selected based on the board above.
>  config NP405H
>  	bool
> -	depends on ASH
> +	#depends on ASH
>  	default y

This always turns this option on, even for Ebony builds.  Should
probably comment out the 'default y' for now as well.

josh
