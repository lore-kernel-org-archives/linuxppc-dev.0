Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id ED75DDDDF9
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2007 22:27:53 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <1189802687.20625.74.camel@basalt>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <982faf82bf1dcc29bcc897422114b6c0@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] fix xmon input on 440
Date: Mon, 17 Sep 2007 07:24:02 -0500
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat Sep 15 06:44:47 EST 2007, Hollis Blanchard wrote:

> Implement udbg_getc() for 440, which fixes xmon input.
> Signed-off-by: Hollis Blanchard <hollisb at us.ibm.com>

>         udbg_putc = udbg_44x_as1_putc;
> +       udbg_getc = udbg_44x_as1_getc;

How about adding udbg_getc_poll as well?

While there are no in-tree users, we can use it for console input later.

milton
