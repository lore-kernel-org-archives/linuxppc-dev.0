Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "Equifax" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 371091007D9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2011 23:14:43 +1100 (EST)
Received: from /spool/local by e28smtp09.in.ibm.com with XMail ESMTP
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Tue, 25 Oct 2011 17:44:40 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 p9PCEbdO4350052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2011 17:44:37 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 p9PCEY6X001519
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2011 17:44:36 +0530
Message-ID: <4EA6A824.2080902@in.ibm.com>
Date: Tue, 25 Oct 2011 17:44:28 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
To: radha krishna <ramamru@gmail.com>
Subject: Re: Kdump/kexec for mpc83xx
References: <CAJ4m0g4TT3dNeRXqiU1oTa+tcjn+62jjrXJYTQjMoOaDAT48xg@mail.gmail.com>
In-Reply-To: <CAJ4m0g4TT3dNeRXqiU1oTa+tcjn+62jjrXJYTQjMoOaDAT48xg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/24/11 18:05, radha krishna wrote:
> Hi Team,
>
> I am using Linux-3.0 on mpc8379 RDB. I have downloaded kexec-tools-2.0.2 package from open source and cross compiled for ppc_6xx.
> But, the kexec is not booting with kernel loaded with "kexec -l".

I am not familiar with mcp8379 RDB. AFAIK, the ppc32 port of kexec-tools work just fine. You may need to
check the kernel side to see if you are setting up the 'real mode' environment for the kernel copy step.

Thanks
Suzuki
