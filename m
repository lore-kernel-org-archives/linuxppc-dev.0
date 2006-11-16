Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E440967C1E
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 09:43:48 +1100 (EST)
Subject: Re: Re:[PATCH 3/16] add base support for Celleb platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <200611161029.kAGATB6i001993@toshiba.co.jp>
References: <200611161029.kAGATB6i001993@toshiba.co.jp>
Content-Type: text/plain
Date: Fri, 17 Nov 2006 09:43:41 +1100
Message-Id: <1163717021.5940.404.camel@localhost.localdomain>
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


> This routine depends on non-standard device-tree property since our older
> boot system eventually lacks standard properties. Our boot system is still
> under development on standard properties.

It might be good then to have the code try the standard method first,
and if it fails, fallback to a separate routine that uses the "old"
method. Once you are confident that old device-trees have been phased
out, you can then submit a patch that removes the fallback.

Cheers
Ben.
