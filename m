Return-Path: <timur.tabi@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id 13A03DDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 06:41:26 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1027154ywh.39
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Nov 2008 11:41:24 -0800 (PST)
Message-ID: <ed82fe3e0811171141x1522c2c7i30711f6d69076df@mail.gmail.com>
Date: Mon, 17 Nov 2008 13:41:24 -0600
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: linuxppc-dev@ozlabs.org
Subject: Re: powerpc: udbg based backend for hvc_console
In-Reply-To: <20081024035434.GF4267@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20081024035434.GF4267@yookeroo.seuss>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 23, 2008 at 9:54 PM, David Gibson
<david@gibson.dropbear.id.au> wrote:
> This patch adds a new backend for the hvc console based on the
> low-level udbg callbacks.  This effectively implements a working
> runtime console in terms of the simple udbg primitives.  This is kind
> of a hack - since udbg isn't something you really want to be using
> routinely - but it's really useful during bringup.

David, I have a stupid question.  I already have an HVC console driver
that works.  Do I need to do anything, other than enable HVC_UDBG, to
get my hvc console drive to use udbg?

-- 
Timur Tabi
Linux kernel developer at Freescale
