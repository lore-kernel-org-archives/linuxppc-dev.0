Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id D00E7B6EE7
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Apr 2012 19:19:24 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 03113-04 for <linuxppc-dev@lists.ozlabs.org>;
 Mon,  2 Apr 2012 10:19:20 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [REGRESSION][PATCH V4 1/3] bpf jit: Make the
 filter.c::__load_pointer helper non-static for the jits
Date: Mon, 2 Apr 2012 10:18:02 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B6ECE@saturn3.aculab.com>
In-Reply-To: <4F75CC63.10405@googlemail.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Jan Seiffert" <kaffeemonster@googlemail.com>,
	<netdev@vger.kernel.org>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Matt Evans <matt@ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> The function is renamed to make it a little more clear what it does.
> It is not added to any .h because it is not for general=20
> consumption, only for bpf internal use (and so by the jits).

I'd have thought it better to put in into a bfp_internal.h
(or similar) with a big warning there about the asm users.

Possibly even worth adding some other defs that the asm
files will need (if there are any).

	David
