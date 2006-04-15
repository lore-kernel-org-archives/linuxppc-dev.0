Return-Path: <jimix@watson.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D5F7C67A44
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Apr 2006 23:09:44 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3FD9Twq026846
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Apr 2006 09:09:29 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3FD9J6P216016
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Apr 2006 09:09:19 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k3FD9IGW015354
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Apr 2006 09:09:19 -0400
In-Reply-To: <20060415074538.GW10412@granada.merseine.nu>
References: <20060413020559.GC24769@pb15.lixom.net>
	<20060413022809.GD24769@pb15.lixom.net>
	<20060413025233.GE24769@pb15.lixom.net>
	<20060413064027.GH10412@granada.merseine.nu>
	<1144925149.4935.14.camel@localhost.localdomain>
	<20060413160712.GG24769@pb15.lixom.net>
	<20060413173121.GJ10412@granada.merseine.nu>
	<1144961564.4935.24.camel@localhost.localdomain>
	<20060414144830.GQ10412@granada.merseine.nu>
	<1145048275.4223.32.camel@localhost.localdomain>
	<20060415074538.GW10412@granada.merseine.nu>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <07A4723B-50D5-4E2D-A292-E9714FFF2E68@watson.ibm.com>
From: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Re: [PATCH] [2/2] POWERPC: Lower threshold for DART enablement to 1GB,
	V2
Date: Sat, 15 Apr 2006 09:09:18 -0400
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Olof Johansson <olof@lixom.net>, paulus@samba.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I believe its in Regatta platforms, spin 180 degrees and ask anton :)
-JX
On Apr 15, 2006, at 3:45 AM, Muli Ben-Yehuda wrote:

> On Sat, Apr 15, 2006 at 06:57:55AM +1000, Benjamin Herrenschmidt  
> wrote:
>
>> Not sure I ever heard about that... What chipsets ?
>
> I'm not sure which IBM pSeries modesl have Calgary in them. Perhaps
> Jon or Olof know?
>
> Cheers,
> Muli
> -- 
> Muli Ben-Yehuda
> http://www.mulix.org | http://mulix.livejournal.com/
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
