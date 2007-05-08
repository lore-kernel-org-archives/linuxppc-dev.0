Return-Path: <srinivasa@in.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 52BB8DDE2A
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 22:05:11 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l48COQf4158710
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 22:24:27 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.250.244])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l48C8I06121102
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 22:08:19 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l48C4lbN016527
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 22:04:47 +1000
Message-ID: <4640675C.6090104@in.ibm.com>
Date: Tue, 08 May 2007 17:34:44 +0530
From: Srinivasa Ds <srinivasa@in.ibm.com>
MIME-Version: 1.0
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: kernel expection generated with 2.6.21-mm1 kernel boot up
References: <463F06E2.5060308@linux.vnet.ibm.com>
	<1178538912.24522.12.camel@concordia.ozlabs.ibm.com>
	<463F1CA9.40501@linux.vnet.ibm.com>
In-Reply-To: <463F1CA9.40501@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kamalesh Babulal wrote:
> 
> 
> Michael Ellerman wrote:
>> On Mon, 2007-05-07 at 16:30 +0530, Kamalesh Babulal wrote:
>>  
>>> Hi,
>>>
>>> I tried compiling and booting up with 2.6.21-mm1 kernel
>>> on the following machine
>>>
>>> Architecture      :    PPC64
>>> CPU Type           :    POWER5 (gr)
>>> Machine Type    :    CHRP IBM,9117-570
>>> Base OS              :    Fedora Core 5
>>>
>>>     
>>
>>  

Looks like problem is in SLUB layer, I unmarked SLUB(CONFIG_SLUB)
option and now system is booting.

Thanks
 Srinivasa DS
