Return-Path: <pbadari@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E8683DDDFA
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 15:51:54 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1T4pIi6011469
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 23:51:18 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1T4pp9m215854
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 21:51:51 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1T4pp5L001531
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 21:51:51 -0700
Message-ID: <47C78F50.7070309@us.ibm.com>
Date: Thu, 28 Feb 2008 20:51:28 -0800
From: Badari Pulavarty <pbadari@us.ibm.com>
MIME-Version: 1.0
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH 0/3] hotplug memory remove updates
References: <1204217028.28696.10.camel@dyn9047017100.beaverton.ibm.com>
	<20080229013957.GQ16241@localdomain>
In-Reply-To: <20080229013957.GQ16241@localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nathan Lynch wrote:
> Badari Pulavarty wrote:
>   
>> Hi Paul,
>>
>> Here are the hotplug memory remove updates for 2.6.25-rc2-mm1.
>>     
>
> How have these been tested?  Have you initiated a memory remove
> operation from the HMC?  That's the only way to catch some bugs...
>   
Yes, They are testing from HMC + running "drmgr" command manually to 
hash out
all the issues.

Thanks,
Badari
