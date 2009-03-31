Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F28BFDDE98
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 00:07:25 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n2VD8pZI032156
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 09:08:51 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n2VD7JbY193560
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 09:07:19 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n2VD7I27030468
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 09:07:19 -0400
Date: Tue, 31 Mar 2009 09:06:29 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Cheng Renquan <crquan@gmail.com>
Subject: Re: please disable several items in 44x/canyonlands_defconfig
Message-ID: <20090331130629.GA563@zod.rchland.ibm.com>
References: <91b13c310903301916x1729f38dj982b185754a7c1df@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <91b13c310903301916x1729f38dj982b185754a7c1df@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 31, 2009 at 10:16:01AM +0800, Cheng Renquan wrote:
>These 3 items are generally not used in 44x/canyonlands board, please
>consider disable them when you change 44x/canyonlands_defconfig next
>time,
>
>CONFIG_PCI_LEGACY
>CONFIG_DAB
>CONFIG_VIDEO_OUTPUT_CONTROL

I've done a bit broader patch that did this for the rest of the 4xx boards
as well.  It should be sitting in my -next tree.

Thanks,
josh
