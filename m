Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id F3C89B70AB
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Feb 2011 05:18:48 +1100 (EST)
Date: Tue, 15 Feb 2011 19:18:56 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Gary Thomas <gary@mlbassoc.com>
Subject: Re: FSL USB in 2.6.37
Message-ID: <20110215191856.67f8f0c4@wker>
In-Reply-To: <4D5ABC25.80104@mlbassoc.com>
References: <4D5ABC25.80104@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 15 Feb 2011 10:47:17 -0700
Gary Thomas <gary@mlbassoc.com> wrote:

> I'm trying to get my platform support working in mainline
> 2.6.37.  I have a MPC8379 which is working well in 2.6.32.
> 
> When I just move my platform to the new kernel, everything
> works except for USB host mode.  Nothing special about my
> platform - it's pretty much like the FSL eval boards (as
> far as this part is concerned).  I can see it start up,
> claim to power up the internal hub, but I never see the
> state change interrupt from the hub.
> 
> Are there any known gotchas here?  Any ideas?

Does this patch [1] help?

[1] http://patchwork.ozlabs.org/patch/78260/
