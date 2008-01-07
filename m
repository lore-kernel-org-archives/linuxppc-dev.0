Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by ozlabs.org (Postfix) with ESMTP id 2BF9CDDE1B
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jan 2008 12:09:18 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so3255587pyg.27
	for <linuxppc-dev@ozlabs.org>; Sun, 06 Jan 2008 17:09:18 -0800 (PST)
Date: Sun, 6 Jan 2008 19:09:10 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Fix remainder calculating bug in single floating point
	division
Message-ID: <20080106190910.7406b5be@vader.jdub.homelinux.org>
In-Reply-To: <1199652574.7291.85.camel@pasglop>
References: <11996296134110-git-send-email-Yu.Liu@freescale.com>
	<1199650065.7291.81.camel@pasglop>
	<66F0B96A-5B53-48D3-BB90-07841F3EA1EE@embeddedalley.com>
	<1199652574.7291.85.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 07 Jan 2008 07:49:33 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Sun, 2008-01-06 at 12:44 -0800, Dan Malek wrote:
> > While it's convenient, I still don't think kernel float
> > emulation should be a solution.  The tools should
> > generate soft-float for the applications and libraries.
> 
> I agree, for deployement, it's definitely not a solution, though it's
> very convenient for us hackers :-)

Hacks have a way of becoming solutions... ;)

josh
