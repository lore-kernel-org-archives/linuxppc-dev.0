Return-Path: <arnd.bergmann@de.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4C23267B79
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 23:10:00 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k5FD9udB025071
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 09:09:57 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k5FD9uLX173304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 09:09:56 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k5FD9uUX016089
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 09:09:56 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Fix 64k pages on non-partitioned machines
Date: Thu, 15 Jun 2006 15:08:46 +0200
References: <17553.16736.157418.936815@cargo.ozlabs.ibm.com>
In-Reply-To: <17553.16736.157418.936815@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Message-Id: <200606151508.46613.arnd.bergmann@de.ibm.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: torvalds@osdl.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 15 June 2006 13:15, Paul Mackerras wrote:
> Linus, without this patch, we can't use 64k pages on Cell systems.  If
> you could apply this before 2.6.17 is released, that would be good.
> If not, I'll send it in post 2.6.17.

Actually, I thought we decided to postpone 64k page support on cell
to 2.6.18 already. This patch alone is not enough to make it work,
at least one more fix is needed for being able to boot, while
the spu file system needs major changes for it.

	Arnd <><
