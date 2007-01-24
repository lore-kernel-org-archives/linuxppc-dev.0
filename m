Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id E30BDDE098
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 08:59:20 +1100 (EST)
Message-ID: <45B7D6B6.2010308@freescale.com>
Date: Wed, 24 Jan 2007 15:59:18 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: [PATCH 05/18] Add ft_first_node().
References: <20070124210707.GE10527@ld0162-tx32.am.freescale.net>
	<45B7D044.7020007@smiths-aerospace.com>
In-Reply-To: <45B7D044.7020007@smiths-aerospace.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jerry Van Baren wrote:
> Have you considered replacing flatdevtree.c with David Gibson's fdtlib? 
>  The interface is a lot cleaner, which likely carries through to the 
> underlying code.
> <http://thread.gmane.org/gmane.linux.ports.ppc64.devel/12771/focus=12877>

I tried pulling from the git tree, but since I'm using the http protocol 
(our firewall unfortunately won't allow the git protocol to go through), 
all I get is:

Cannot get remote repository information.
Perhaps git-update-server-info needs to be run there?

-Scott
