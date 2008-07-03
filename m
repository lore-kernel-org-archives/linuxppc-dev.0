Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 08312DDF88
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 23:24:50 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m63DOjxv007050
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Jul 2008 09:24:46 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m63DOSMP156568
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Jul 2008 09:24:28 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m63DOSGM003880
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Jul 2008 09:24:28 -0400
Date: Thu, 3 Jul 2008 09:21:07 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: John Linn <John.Linn@xilinx.com>
Subject: Re: [PATCH] powerpc: Xilinx: add 440 platform support
Message-ID: <20080703092107.3c0d9122@zod.rchland.ibm.com>
In-Reply-To: <20080703132047.62AA8A20055@mail137-wa4.bigfish.com>
References: <20080701224829.EC51111E8013@mail35-sin.bigfish.com>
	<20080703091448.4e298ce8@zod.rchland.ibm.com>
	<20080703132047.62AA8A20055@mail137-wa4.bigfish.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 3 Jul 2008 07:20:45 -0600
John Linn <John.Linn@xilinx.com> wrote:

> XILINX_VIRTEX_5_FXT is the FPGA architecture, which has a 440 and can be
> on a number of different boards.

Could you add that as some help text under the config option for 5_FXT?
That way you don't have to answer that question over and over from
stupid people like me :)

josh
