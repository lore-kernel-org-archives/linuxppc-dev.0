Return-Path: <jonmasters@gmail.com>
Received: from mproxy.gmail.com (rproxy.gmail.com [64.233.170.198])
	by ozlabs.org (Postfix) with ESMTP id 910772BC0F
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Sep 2004 10:24:30 +1000 (EST)
Received: by mproxy.gmail.com with SMTP id 76so4182708rnk
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Sep 2004 17:24:26 -0700 (PDT)
Message-ID: <35fb2e5904092617246482c908@mail.gmail.com>
Date: Mon, 27 Sep 2004 01:24:26 +0100
From: Jon Masters <jonmasters@gmail.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Cisco Aironet, PowerBook PCMCIA
Reply-To: jonathan@jonmasters.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

Couldn't find my regular prism2 card so I tried a Cisco Aironet 340 I
recall using once previously. Seems to be some hard lock issues on my
powerbook going on here.

I'll take a look at why this happens, just passing on that fact in
case anyone else has one of these and wants to help out. I've no
useful logs from the box in question yet.

Cheers,

Jon.

P.S. Incidentally I've found PCMCIA is more flaky on the Powerbook
with a 2.6 kernel than with a 2.4 - removing any device without first
ejecting it will result in a hard lockup. Will investigate.
