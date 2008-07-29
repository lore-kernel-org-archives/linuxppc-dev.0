Return-Path: <jimix@watson.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 48F01DDDF3
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 20:43:04 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6TAgxee006274
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 06:42:59 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6TAgxbR219422
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 06:42:59 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6TAgxpG005762
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 06:42:59 -0400
Message-Id: <612EFEB1-E426-4E1B-86F6-BB2D484F0374@watson.ibm.com>
From: Jimi Xenidis <jimix@watson.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080728002336.4a7883f1.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] Fix powerpc64 build if CONFIG_EPOLL=n
Date: Tue, 29 Jul 2008 06:42:59 -0400
References: <B6E6E232-5793-4BBB-BD82-95B19716ACE4@watson.ibm.com>
	<20080728002336.4a7883f1.sfr@canb.auug.org.au>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 27, 2008, at 10:23 AM, Stephen Rothwell wrote:

> Hi Jimi,
>
> On Sun, 27 Jul 2008 08:48:09 -0400 Jimi Xenidis  
> <jimix@watson.ibm.com> wrote:
>>
>> Declate compat_sys_epoll_pwait as a conditional syscall like the rest
>> of the epoll interfaces.
>> We could have put an #ifdef around the entry in include/asm-powerpc/
>> systbl.h, but IMHO this is ultimately correct patch.
>
> Already in Linus' tree - commit  
> 5f17156fc55abac476d180e480bedb0f07f01b14
> "Fix build on COMPAT platforms when CONFIG_EPOLL is disabled"

Wow, missed by less than a week.
Thanks for the pointer.
-JX

>
>
> -- 
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/
