Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id 134DEB7D4C
	for <linuxppc-dev@ozlabs.org>; Mon, 10 May 2010 08:07:34 +1000 (EST)
Received: by gyf2 with SMTP id 2so1497986gyf.15
	for <linuxppc-dev@ozlabs.org>; Sun, 09 May 2010 15:07:33 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4BC885C0.5000509@freemail.hu>
References: <4BC885C0.5000509@freemail.hu>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 10 May 2010 00:07:13 +0200
Message-ID: <o2lfa686aa41005091507s9bdb5478ld1b0a72965cd261b@mail.gmail.com>
Subject: Re: serial driver for MPC5554?
To: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2010/4/16 N=E9meth M=E1rton <nm127@freemail.hu>:
> Hi,
>
> is there somebody working on the MPC5554 [1] serial port driver?

No

> I could
> only find linux/drivers/serial/mpc52xx_uart.c but I'm not sure whether
> this could work together with the eSCI on-chip hardware module which
> can be found in MPC5554 [2].

Unfortunately, not the same device.  You'll have to start from scratch it s=
eems.

g.
