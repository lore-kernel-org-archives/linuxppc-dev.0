Return-Path: <scottwood@freescale.com>
Message-ID: <4672EE95.3030407@freescale.com>
Date: Fri, 15 Jun 2007 14:55:01 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] boot: find initrd location from device-tree
References: <111819314606b8b45671.846930886.miltonm@bga.com>
In-Reply-To: <111819314606b8b45671.846930886.miltonm@bga.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Milton Miller wrote:
> The file name dtscan reflects the possibility that simiar functions
> like the rmo_top might be added to the file.

Aren't these kind of things what devtree.c is for?

-Scott
