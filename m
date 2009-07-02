Return-Path: <markn@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0D2D7B70EE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 11:30:01 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id n621S9El020076
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jul 2009 11:28:09 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n621U0cC262420
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jul 2009 11:30:00 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n621U0GD031531
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jul 2009 11:30:00 +1000
From: Mark Nelson <markn@au1.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: misaligned load/store in ppc32 memcpy
Date: Thu, 2 Jul 2009 11:32:14 +1000
References: <6ABDC992-9D67-4C9C-A3A7-59F408FC9E50@kernel.crashing.org>
In-Reply-To: <6ABDC992-9D67-4C9C-A3A7-59F408FC9E50@kernel.crashing.org>
MIME-Version: 1.0
Message-Id: <200907021132.14923.markn@au1.ibm.com>
Content-Type: Text/Plain;
  charset="iso-8859-15"
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kumar,

On Wednesday 01 July 2009 07:56:31 Kumar Gala wrote:
> Mark,
> 
> Ben pointed me to you regarding my question if we should be expecting misaligned load/store operations in the ppc32 mempcy that exists in copy_32.S.
> 
> (To be more specific, I'm seeing this behavior and wondering if we really should have memcpy avoid doing word size ld/st if the addresses aren't also aligned)
> 

That's a good question; but because I don't really know very much about the
ppc32 cores that this memcpy routine was written and tested with (let alone
the newer embedded variations) I'll CC Paul and hopefully he can let us know :)

Thanks!
Mark
