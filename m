Return-Path: <mjw@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DED4367C9C
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 03:48:24 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAMGmLFn018678
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 11:48:21 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAMGmLbq515764
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 09:48:21 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAMGmL5k026860
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 09:48:21 -0700
Received: from wecm-9-67-39-53.wecm.ibm.com (wecm-9-67-39-53.wecm.ibm.com
	[9.67.39.53])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	kAMGmKi5026800
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 09:48:21 -0700
Subject: Re: [PATCH] powerpc: Make 970MP detectable by oprofile
From: Mike Wolf <mjw@us.ibm.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1164141715.9752.5.camel@localhost>
References: <1164141715.9752.5.camel@localhost>
Content-Type: text/plain
Date: Wed, 22 Nov 2006 10:48:18 -0600
Message-Id: <1164214098.5704.1.camel@localhost>
Mime-Version: 1.0
Reply-To: mjw@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> >Change the oprofile_cpu_type in cputables.c to be ppc64/970MP.  Oprofile
> >needs to distinquish the MP from other 970 processors so it can add some
> >new counters specific to the 970MP
> >
>Just out of curiosity, what are those?  I never saw any,
>but I'd love to know :-)


They are the IBM JS21 blades
