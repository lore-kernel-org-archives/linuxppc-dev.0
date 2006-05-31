Return-Path: <mkravetz@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 71DB4679E2
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jun 2006 06:41:31 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k4VKfSrb020756
	for <linuxppc-dev@ozlabs.org>; Wed, 31 May 2006 16:41:28 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k4VKfSDF136656
	for <linuxppc-dev@ozlabs.org>; Wed, 31 May 2006 16:41:28 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k4VKfSJv027924
	for <linuxppc-dev@ozlabs.org>; Wed, 31 May 2006 16:41:28 -0400
Received: from localhost.localdomain (dyn9047021124.beaverton.ibm.com
	[9.47.21.124])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k4VKfRnH027861
	for <linuxppc-dev@ozlabs.org>; Wed, 31 May 2006 16:41:27 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.6/8.13.4) with ESMTP id k4VKfij4009907
	for <linuxppc-dev@ozlabs.org>; Wed, 31 May 2006 13:41:44 -0700
Received: (from mkravetz@localhost)
	by localhost.localdomain (8.13.6/8.13.6/Submit) id k4VKfi3h009906
	for linuxppc-dev@ozlabs.org; Wed, 31 May 2006 13:41:44 -0700
Date: Wed, 31 May 2006 13:41:44 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Collecting hypervisor call stats
Message-ID: <20060531204144.GA7909@w-mikek2.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We would like to add code that gathers statistics about hypervisor calls.
It would keep track of things like # of calls made for each opcode as well
as time spent processing the calls.

The 'obvious' place to gather such statistics would be from within the
routines making hcalls in hvCall.S.  Once thing that I have noticed is
the following comment at the beginning hvCall.S:

 * NOTE: this file will go away when we move to inline this work.

So, it appears someone thought/thinks these routines should be inlined.  
I assume this is for performance reasons?  If this is the case, then I
suspect gathering of statistics (which would introduce overhead) would
meet resistance?

Comments about the feasibility of adding such statistic gathering code
would be appreciated.

Thanks,
-- 
Mike
