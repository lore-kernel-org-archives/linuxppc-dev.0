Return-Path: <mohan@in.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4F867DE15D
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 18:14:41 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7J8EZDp019629
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 04:14:35 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7J8CJYJ233904
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 04:12:19 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7J8CJ1C016709
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 04:12:19 -0400
Message-ID: <48AA804B.4050508@in.ibm.com>
Date: Tue, 19 Aug 2008 13:41:55 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 0/5] Relocatable 64-bit kernel using linker PIE support
References: <18594.14443.340604.693747@cargo.ozlabs.ibm.com>
	<48A9AF1D.5050700@in.ibm.com>
	<18602.9527.358136.469335@cargo.ozlabs.ibm.com>
	<48AA5B8E.2000801@in.ibm.com>
	<18602.27761.214066.779209@cargo.ozlabs.ibm.com>
In-Reply-To: <18602.27761.214066.779209@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Mohan Kumar M writes:
> 
>> Attaching the .config
> 
> Hmmm, your config works for me on a POWER6 partition here, whether I
> netboot the zImage.pseries or boot it with yaboot.  I wonder if your
> toolchain is an older version.  What is the output from ld --version
> and gcc --version?

# ld --version
GNU ld version 2.16.91.0.5 20051219 (SUSE Linux)

# gcc --version
gcc (GCC) 4.1.2 20070115 (prerelease) (SUSE Linux)

If the problem is related to toolchain version, which one you recommend 
to test?

> 
> Also, could you send me off-list your compiled vmlinux?

You can download the zipped vmlinux at
http://mohankumar.m.googlepages.com/vmlinux.gz

Regards,
Mohan.
