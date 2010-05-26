Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 34B2FB6EFF
	for <linuxppc-dev@ozlabs.org>; Wed, 26 May 2010 22:54:39 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4QClHTo012026
	for <linuxppc-dev@ozlabs.org>; Wed, 26 May 2010 06:47:17 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4QCsPhs038384
	for <linuxppc-dev@ozlabs.org>; Wed, 26 May 2010 06:54:25 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o4QCsLhT028694
	for <linuxppc-dev@ozlabs.org>; Wed, 26 May 2010 06:54:22 -0600
Date: Wed, 26 May 2010 08:54:09 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] powerpc/44x: icon: select SM502 and frame buffer
	console support
Message-ID: <20100526125409.GK24511@zod.rchland.ibm.com>
References: <1274870190-4712-1-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1274870190-4712-1-git-send-email-agust@denx.de>
Cc: linuxppc-dev@ozlabs.org, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 26, 2010 at 12:36:30PM +0200, Anatolij Gustschin wrote:
>Enables SM502 frame buffer and framebuffer console
>in the default config file
>
>Signed-off-by: Anatolij Gustschin <agust@denx.de>

Thanks.  I put this in my -next branch.  Hopefully Ben pulls soon.

josh
