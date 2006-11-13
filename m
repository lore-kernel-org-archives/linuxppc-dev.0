Return-Path: <msm@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 87CCE67D9F
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 07:50:44 +1100 (EST)
Received: from az33smr01 (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	kADKoh0j004815
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 13:50:43 -0700 (MST)
Subject: Re: [PATCH] make git ignore new wrapper generated files
From: Matthew McClintock <msm@freescale.com>
To: Kim Phillips <kim.phillips@freescale.com>
In-Reply-To: <20061110180830.419c28bd.kim.phillips@freescale.com>
References: <20061110180830.419c28bd.kim.phillips@freescale.com>
Content-Type: text/plain
Date: Mon, 13 Nov 2006 14:50:20 -0600
Message-Id: <1163451020.5463.10.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-11-10 at 18:08 -0600, Kim Phillips wrote:
> The new 'wrapper' code generates files that git should ignore;
> add them to .gitignore.

Why don't we just add these files to be cleaned correctly?

-Matthew
