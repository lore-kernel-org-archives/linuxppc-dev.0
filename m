Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C4CBFDDEC0
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 00:11:04 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4GD97hb020526
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 09:09:07 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4GEAwH3471926
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 10:10:58 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4GEAwN4018587
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 10:10:58 -0400
Subject: Re: [PATCH] [POWERPC] remove build warnings in windfarm_core
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20070516112449.9f0ae1a2.sfr@canb.auug.org.au>
References: <20070514163219.9d78cde0.sfr@canb.auug.org.au>
	<17993.20745.432703.238649@cargo.ozlabs.ibm.com>
	<20070516112449.9f0ae1a2.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Wed, 16 May 2007 09:10:06 -0500
Message-Id: <1179324607.16032.70.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-16-05 at 11:24 +1000, Stephen Rothwell wrote:

> -	device_create_file(&wf_platform_device.dev, &new_ct->attr);
> +	if (device_create_file(&wf_platform_device.dev, &new_ct->attr))
> +		printk(KERN_WARNING "windfarm: device_creat_file failed"

Hi Stephen, 

s/creat_/create_/


-Will
