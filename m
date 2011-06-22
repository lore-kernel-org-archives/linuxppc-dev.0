Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EA7FEB6F59
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jun 2011 02:14:39 +1000 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p5MG1Xob031444
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2011 10:01:33 -0600
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p5MGE2RG038458
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2011 10:14:04 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p5MGJMRO028361
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2011 10:19:22 -0600
Date: Wed, 22 Jun 2011 12:14:01 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Mike Williams <mike@mikebwilliams.com>
Subject: Re: [PATCH] powerpc,	ppc4xx: Update canyonlands and glacier boards
	DTS to add HW RNG	support
Message-ID: <20110622161401.GE2414@zod.rchland.ibm.com>
References: <1308758983-15687-1-git-send-email-mike@mikebwilliams.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308758983-15687-1-git-send-email-mike@mikebwilliams.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 22, 2011 at 12:09:43PM -0400, Mike Williams wrote:
>
>Signed-off-by: Mike Williams <mike@mikebwilliams.com>
>---
> arch/powerpc/boot/dts/canyonlands.dts |    5 +++++
> arch/powerpc/boot/dts/glacier.dts     |    5 +++++
> 2 files changed, 10 insertions(+), 0 deletions(-)

Thanks, you beat me to it!  I'll get these into my -next branch soon.  I
have a similar change for the Sequoia DTS.

josh
