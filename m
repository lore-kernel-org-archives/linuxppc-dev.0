Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D4D61B7BFE
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Dec 2009 04:39:25 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nB4HQxnq013055
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Dec 2009 10:26:59 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nB4HdDut064702
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Dec 2009 10:39:15 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nB4AStKw019999
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Dec 2009 03:28:57 -0700
Date: Fri, 4 Dec 2009 12:39:02 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Add PowerPC patterns
Message-ID: <20091204173902.GK2937@zod.rchland.ibm.com>
References: <20091202091951.5ec6bb83@hyperion.delvare>
	<1259894454.2076.1246.camel@pasglop>
	<20091204103434.0a754925@hyperion.delvare>
	<1259920775.2076.1273.camel@pasglop>
	<1259947019.22783.116.camel@Joe-Laptop.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1259947019.22783.116.camel@Joe-Laptop.home>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, LKML <linux-kernel@vger.kernel.org>,
	Jean Delvare <khali@linux-fr.org>, Paul Mackerras <paulus@samba.org>,
	Colin Leroy <colin@colino.net>, "Darrick J. Wong" <djwong@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 04, 2009 at 09:16:59AM -0800, Joe Perches wrote:
> LINUX FOR POWERPC EMBEDDED PPC4XX
> M:	Josh Boyer <jwboyer@linux.vnet.ibm.com>
>@@ -3221,6 +3228,8 @@ W:	http://www.penguinppc.org/
> L:	linuxppc-dev@ozlabs.org
> T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git
> S:	Maintained
>+F:	arch/powerpc/platforms/40x/
>+F:	arch/powerpc/platforms/44x/

This is mostly complete.  There are a few files under arch/powerpc/sysdev/, and
arch/powerpc/boot/ as well, but I don't think they're entirely necessary.

For the 4xx parts:

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

josh
