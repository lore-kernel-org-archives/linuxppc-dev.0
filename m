Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 06ABBDDE39
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 04:58:54 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l16HxV7U025666
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Feb 2007 12:59:31 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l16HwoHS295874
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Feb 2007 12:58:50 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l16HwnPV000931
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Feb 2007 12:58:50 -0500
Date: Tue, 6 Feb 2007 11:58:49 -0600
To: Manish Ahuja <ahuja@austin.ibm.com>
Subject: Re: [PATCH]Enabling Auto poweron after power is restored.
Message-ID: <20070206175849.GW5616@austin.ibm.com>
References: <45707469.9060604@austin.ibm.com> <4575E76C.7030300@austin.ibm.com>
	<17785.415.574041.518517@cargo.ozlabs.ibm.com>
	<458EBE02.3010401@austin.ibm.com>
	<17827.5922.667200.166153@cargo.ozlabs.ibm.com>
	<45C40C97.807@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45C40C97.807@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 02, 2007 at 10:16:23PM -0600, Manish Ahuja wrote:
> Resubmitting this patch with a sysfs interface instead of /proc.
> During some off line discussion, /sys/power was suggested as a possible 
> candidate area for this functionality to reside.
> 
> -------------------------------------------------------------------------------------------------------------------------
> 
> During power outages, the ups notifies the system for a shutdown. In the 
> current setup, it isn't possible to poweron when power is restored. This 
> patch fixes the issue by calling the right ibm,power-off-ups token 
> during such events. It also adds a sysfs interface so that rc.powerfail 
> can parse the epow events and modify the power-off behavior accordingly 
> to enable the right token to be called.
> 
> Signed-off-by: Manish Ahuja <ahuja@austin.ibm.com>

Acked-by: Linas Vepstas <linas@austin.ibm.com>


--linas
