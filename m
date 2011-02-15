Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [64.234.241.98])
	by ozlabs.org (Postfix) with ESMTP id D0C56B70AB
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Feb 2011 04:47:21 +1100 (EST)
Message-ID: <4D5ABC25.80104@mlbassoc.com>
Date: Tue, 15 Feb 2011 10:47:17 -0700
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Linux PPC Development <linuxppc-dev@ozlabs.org>
Subject: FSL USB in 2.6.37
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm trying to get my platform support working in mainline
2.6.37.  I have a MPC8379 which is working well in 2.6.32.

When I just move my platform to the new kernel, everything
works except for USB host mode.  Nothing special about my
platform - it's pretty much like the FSL eval boards (as
far as this part is concerned).  I can see it start up,
claim to power up the internal hub, but I never see the
state change interrupt from the hub.

Are there any known gotchas here?  Any ideas?

Thanks

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
