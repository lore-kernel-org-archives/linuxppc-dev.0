Return-Path: <mkravetz@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0D91A679E6
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2006 06:43:15 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k2SJh59N028570
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Mar 2006 14:43:05 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2SJkBdP182868
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Mar 2006 12:46:11 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k2SJh4Ig014361
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Mar 2006 12:43:04 -0700
Date: Tue, 28 Mar 2006 11:42:30 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Workaround for RTAS bug
Message-ID: <20060328194230.GC5070@w-mikek2.ibm.com>
References: <20060327231959.GA15383@w-mikek2.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060327231959.GA15383@w-mikek2.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 27, 2006 at 03:20:00PM -0800, Mike Kravetz wrote:
> Also note that the 32 bit version of enter_rtas() should have the same
> work around even though the chances of hitting the bug are much smaller
> due to the lack of DLPAR on 32 bit kernels.  However, my assembly skills
> are a bit rusty and the 32 bit code doesn't seem to follow the conventions
> for where things should be saved.  In addition, I don't have a system
> to test 32 bit kernels.  Help creating and at least touch testing the
> same workaround for 32 bit would be appreciated.

Upon further examination, there does not appear to be any exposure to
this issue on 32 bit kernels.  Therefore, the original patch for 64 bit
should be the only workaround that is required.

-- 
Mike
