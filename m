Return-Path: <shawnxjin@gmail.com>
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.205])
	by ozlabs.org (Postfix) with ESMTP id 3B2FD6890B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Jan 2006 05:45:47 +1100 (EST)
Received: by nproxy.gmail.com with SMTP id p46so1692222nfa
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 09 Jan 2006 10:45:45 -0800 (PST)
Message-ID: <c3d0340b0601091045y5eac88d3m644f3fc79fd9f6a4@mail.gmail.com>
Date: Mon, 9 Jan 2006 10:45:45 -0800
From: Shawn Jin <shawnxjin@gmail.com>
To: "David H. Lynch Jr." <dhlii@dlasys.net>
In-Reply-To: <43BC57E7.40408@dlasys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20051208231947.92EB9353F77@atlas.denx.de>
	<43BC57E7.40408@dlasys.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: RESEND:Problems starting /init
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>         But I can not get busybox to output a thing either run as /init o=
r run
> as /bin/sh.
>
>         I have aslo tried /bin/sash - no output.
>         I have even cross compiled sash - with all kinds of "I am here"
> debugging scattered through main(), If I runn it on a powerbook, I get
> what I expect. If I run it as /bin/sh on the e12 I get no output.
>
>
>         Does anyone even have any ideas what I can look at ?

Another thing you may try is to make sure the UART works correctly
with interrupt mode. So set some breakpoints in UART's IRS to see what
happens.

Regards,
-Shawn.
