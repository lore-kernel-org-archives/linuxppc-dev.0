Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 05262DDE02
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Dec 2007 05:10:21 +1100 (EST)
In-Reply-To: <20071216085858.55ffddbe@vader.jdub.homelinux.org>
References: <1197705316-17618-1-git-send-email-sr@denx.de>
	<20071216061959.GD21311@localhost.localdomain>
	<20071216085858.55ffddbe@vader.jdub.homelinux.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f3ddb435a7a71cea8362ed73eb154200@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 4xx: Add aliases node to 4xx dts files
Date: Sun, 16 Dec 2007 19:10:02 +0100
To: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Applied to my candidates tree.  Though I'd really like dtc to be merged
> so that we can figure out what the in-kernel version will support.

Hopefully some version that stores path strings in the properties
in /aliases, and not phandles.  Or does that current version of DTC
do that correctly already, and just has an inconvenient source syntax?


Segher
