Return-Path: <jonsmirl@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.227])
	by ozlabs.org (Postfix) with ESMTP id 77253DDE2D
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Sep 2007 01:38:13 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 71so1419470wri
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Sep 2007 08:38:12 -0700 (PDT)
Message-ID: <9e4733910709280838v5deebfdbo62b9097faed9c937@mail.gmail.com>
Date: Fri, 28 Sep 2007 11:38:10 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Juergen Beisert" <jbe@pengutronix.de>
Subject: Re: [RFC PATCH v0.1] net driver: mpc52xx fec
In-Reply-To: <200709281707.45030.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070810095153.GC13994@moe.telargo.com>
	<200709271907.50479.jbe@pengutronix.de>
	<200709281707.45030.jbe@pengutronix.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/28/07, Juergen Beisert <jbe@pengutronix.de> wrote:
> But I can't run it a second time, as the network on target's side doesn't
> respond. Any idea?

Do the stress tests complete on a non-rt kernel?

That will narrow down the type of bug being looked for.

-- 
Jon Smirl
jonsmirl@gmail.com
