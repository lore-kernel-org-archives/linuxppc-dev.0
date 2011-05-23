Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C05C1B6FB0
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 May 2011 22:39:38 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e35.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p4NCMFBi004538
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 May 2011 06:22:15 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p4NCdPPs108082
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 May 2011 06:39:25 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p4N6dOTB022012
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 May 2011 00:39:25 -0600
Date: Mon, 23 May 2011 08:40:35 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Muhammad Waseem <vasim98@gmail.com>
Subject: Re: UART #1 access on Sequoia board
Message-ID: <20110523124035.GJ25179@zod.rchland.ibm.com>
References: <BANLkTims8CrK6s0bJZPBt3jTDRDKzg2e-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTims8CrK6s0bJZPBt3jTDRDKzg2e-A@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 23, 2011 at 11:34:26AM +0500, Muhammad Waseem wrote:
>Hello,
>   I am working on PPC440EPx (Sequoia) to access its UART # 1 port for data
>transfer, while UART # 0 is connected to remote terminal access on host.
>However there is no module/driver listed for UART # 1 using 'lsmod'. The
>kernel version is 2.6.23. How can I access the UART # 1 in user space and/or
>kernel space? Do I need to develop own BSP for this? please help.

The driver is normally built into the kernel.  If the board DTS file has
both UARTs listed, and you have /dev/ttyS1 on your rootfs you should be
able to use it.  However, Sequoia wasn't added until 2.6.24, so I'm not
really sure what kernel flavor you are using.

josh
