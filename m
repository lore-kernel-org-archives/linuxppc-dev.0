Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9C6C7B6F68
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 May 2011 20:34:18 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e37.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p4RAVA6p008322
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2011 04:31:10 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	p4RAY3WL155178
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2011 04:34:03 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p4R4XZAZ029816
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 May 2011 22:33:35 -0600
Date: Fri, 27 May 2011 06:35:16 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Muhammad Waseem <vasim98@gmail.com>
Subject: Re: Linuxppc-dev Digest, Vol 81, Issue 140
Message-ID: <20110527103516.GA2557@zod.rchland.ibm.com>
References: <mailman.1.1306461602.19013.linuxppc-dev@lists.ozlabs.org>
	<BANLkTima3uLXvF3Zri5DjDDFHAB+CZMDgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTima3uLXvF3Zri5DjDDFHAB+CZMDgg@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 27, 2011 at 12:26:20PM +0500, Muhammad Waseem wrote:
>I have developed a simple polling based serial device driver for PC's serial
>port (COM1: 0x3F8) which works fine. Now I want to implement the same on
>UART # 1 of PPC440EPx (Sequoia board).
>
>By changing the base address 0x3F8 to UART# 1 base address (0xEF600400) in
>Sequoia it does not work and return all the registers contents
>from 0xEF600400 to 0xEF600407 as 0xFF.
>
>Whereas existing ttyS1 driver works for UART# 1.
>
>How can I access the UART# 1 registers in a custom serial driver under
>kernel space.

If you post your driver code, we can review it.

josh
