Return-Path: <Jonathan.Haws@sdl.usu.edu>
Received: from kronos.usurf.usu.edu (kronos.usurf.usu.edu [129.123.194.129])
	by ozlabs.org (Postfix) with ESMTP id E38B9B7BA8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Oct 2009 05:43:08 +1100 (EST)
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 26 Oct 2009 12:43:00 -0600
Subject: Network Stack SKB Reallocation
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F0330BEB38D@midas.usurf.usu.edu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Quick question about the network stack in general:

Does the stack itself release an SKB allocated by the device driver back to=
 the heap upstream, or does it require that the device driver handle that?

Thanks!

Jonathan
