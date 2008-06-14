Return-Path: <ron_madrid@sbcglobal.net>
Received: from web83513.mail.sp1.yahoo.com (web83513.mail.sp1.yahoo.com
	[216.252.120.169]) by ozlabs.org (Postfix) with SMTP id 3258FDDF7D
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jun 2008 10:19:04 +1000 (EST)
Date: Fri, 13 Jun 2008 17:19:03 -0700 (PDT)
From: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Re: Using DMA interrupt on MPC8313
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <485308AA.9050802@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <397587.26957.qm@web83513.mail.sp1.yahoo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So are you implying that the request_irq function should work without any other initialization
function before it?

Ron
--- Timur Tabi <timur@freescale.com> wrote:

> Ron Madrid wrote:
> > I don't know why request_irq is succeeding when the fsldma and dmaengine drivers are
> installed. 
> > I'm using the same dts in both cases.
> 
> At this point, my only suggestion is to debug the request_irq() call and 
> see what exactly fails.
> 
