Return-Path: <hollis@penguinppc.org>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.131])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9BB3B67FA5
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Aug 2005 01:00:33 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e33.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j7IEnxf5360616
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Aug 2005 10:50:00 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id
	j7IEnUJ7464112
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Aug 2005 08:49:30 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	j7IEnsc4014020
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Aug 2005 08:49:54 -0600
In-Reply-To: <20050818065554.28998.qmail@webmail30.rediffmail.com>
References: <20050818065554.28998.qmail@webmail30.rediffmail.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <af1ccb92f79134b97322627cfe053c7e@penguinppc.org>
From: Hollis Blanchard <hollis@penguinppc.org>
Date: Thu, 18 Aug 2005 09:49:53 -0500
To: somshekar chandrashekar kadam <som_kadam1@rediffmail.com>
Cc: Linux PPC Dev <linuxppc-dev@ozlabs.org>
Subject: Re: linuxppc cross compiler 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Aug 18, 2005, at 1:55 AM, somshekar chandrashekar kadam wrote:
>
>  need to set the cross compiler for Linux 2.6 PPC from scratch on X86=20=

> host=A0 , is there any howto or anyother document , i saw only denx =
eldk=20
> supporting it . wanted to build entire cross compiler from scratch ,=20=

> please direct me to any good link if it is there , tried to open the=20=

> link given on Embedded PowerPC linux howto , that page doesnt exist=20
> anymore ,please suggest guys which one is better=A0

http://penguinppc.org/dev/crosstool.php has information on using=20
crosstool, which does it all for you.

Sorry about the broken link in the HOWTO.

-Hollis=
