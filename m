Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id A025ADDEE1
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 18:13:34 +1000 (EST)
Date: Fri, 16 May 2008 10:13:30 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Michael Chan <mchan@broadcom.com>
Subject: Re: dead network on JS21 with tg3 driver after flowcontrol changes
Message-ID: <20080516081330.GA26530@aepfle.de>
References: <20080515121340.GA23033@aepfle.de>
	<20080515171520.GA20953@localdomain>
	<1210881078.22745.9.camel@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1210881078.22745.9.camel@dell>
Cc: linuxppc-dev@ozlabs.org, Matt Carlson <mcarlson@broadcom.com>,
	netdev <netdev@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 15, Michael Chan wrote:

> Matt, I think that's very likely the problem.  If we are trying to
> establish link in parallel detect mode, the flow control settings may
> not match.  If we do not enter the if statement to do nothing, we will
> keep autonegotiating forever and never establish link.

Yes, this patch fixes nfsroot for me. Thanks.
mii-tool is not shipped anymore, even in SLES10.
I assume that ethtool is the replacement?

Olaf
