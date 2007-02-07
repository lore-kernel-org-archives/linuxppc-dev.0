Return-Path: <ahuja@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 31480DDDEF
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 06:42:41 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l17JhF0b013553
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Feb 2007 14:43:15 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l17JgZMh204904
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Feb 2007 14:42:35 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l17JgYHQ029427
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Feb 2007 14:42:34 -0500
Message-ID: <45CA2BA6.3070201@austin.ibm.com>
Date: Wed, 07 Feb 2007 13:42:30 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH]Enabling Auto poweron after power is restored.
References: <45707469.9060604@austin.ibm.com>	<4575E76C.7030300@austin.ibm.com>	<17785.415.574041.518517@cargo.ozlabs.ibm.com>	<458EBE02.3010401@austin.ibm.com>	<17827.5922.667200.166153@cargo.ozlabs.ibm.com>	<45C40C97.807@austin.ibm.com>
	<17865.14407.190426.642030@cargo.ozlabs.ibm.com>
In-Reply-To: <17865.14407.190426.642030@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
>  or move all this logic into
> arch/powerpc/platforms/pseries (i.e., make the pSeries setup.c set
> ppc_md.power_off to a pSeries-specific power off routine where you do
> this logic, setting it to rtas_power_off).
>
> Paul.
>   

Duh, of course, thats how it should have been done.. Sorry I didn't 
think of it myself..
Will amend that as well.

-Manish
