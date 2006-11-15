Return-Path: <srinivasa@in.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C36E467C59
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 15:04:49 +1100 (EST)
Received: from sd0112e0.au.ibm.com (d23rh903.au.ibm.com [202.81.18.201])
	by ausmtp05.au.ibm.com (8.13.8/8.13.6) with ESMTP id kAFG6cu06701296
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 15:06:39 -0100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.250.237])
	by sd0112e0.au.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAF47hkB219828
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 15:07:50 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAF43lAm022946
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 15:03:48 +1100
Message-ID: <455A9C89.9090802@in.ibm.com>
Date: Wed, 15 Nov 2006 10:20:17 +0530
From: Srinivasa Ds <srinivasa@in.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [RFC] [PATCH] cpu_hotplug on IBM JS20 system
References: <45586EB5.40409@in.ibm.com>	<1163453995.5940.11.camel@localhost.localdomain>	<4559C6A9.4070204@in.ibm.com>
	<1163559536.19171.13.camel@localhost.localdomain>
In-Reply-To: <1163559536.19171.13.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: ego@in.ibm.com, anton@au1.ibm.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Tue, 2006-11-14 at 19:07 +0530, Srinivasa Ds wrote:
>   
>> Hi
>> when I tried to hot plug a cpu on IBM bladecentre JS20 system,it dropped 
>> in to xmon.
>>     
>
> How did you try to hot plug a cpu? Through sysfs/hmc/somethingelse ?
>   
echo 0 > /sys/devices/system/cpu/cpu1/online
> cheers
>
>   
