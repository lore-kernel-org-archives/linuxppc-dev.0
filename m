Return-Path: <nschichan@freebox.fr>
Received: from smtp4-g19.free.fr (smtp4-g19.free.fr [212.27.42.30])
	by ozlabs.org (Postfix) with ESMTP id 67B05DDDCA
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Sep 2007 23:48:35 +1000 (EST)
Received: from smtp4-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 986A86F525
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Sep 2007 15:48:33 +0200 (CEST)
Received: from bobafett.staff.proxad.net (bobafett.staff.proxad.net
	[213.228.1.121])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 8B6FB6F515
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Sep 2007 15:48:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by bobafett.staff.proxad.net (Postfix) with ESMTP id 146E02868E
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Sep 2007 15:48:29 +0200 (CEST)
Received: from bobafett.staff.proxad.net ([127.0.0.1])
	by localhost (bobafett.staff.proxad.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id jLQFhJsc8sqc for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Sep 2007 15:48:28 +0200 (CEST)
Received: from nschichan.priv.staff.proxad.net
	(nschichan.priv.staff.proxad.net [172.18.3.120])
	by bobafett.staff.proxad.net (Postfix) with ESMTP id 20B33287A3
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Sep 2007 15:48:28 +0200 (CEST)
From: Nicolas Schichan <nschichan@freebox.fr>
To: linuxppc-embedded@ozlabs.org
Subject: Re: random panic and freezes on mpc8349 itx
Date: Mon, 10 Sep 2007 15:48:27 +0200
References: <200709071405.06500.nschichan@freebox.fr>
	<BAF8B1E0BB28024A90895E746A3B610D1C2BDF@twx-exch01.twacs.local>
In-Reply-To: <BAF8B1E0BB28024A90895E746A3B610D1C2BDF@twx-exch01.twacs.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709101548.27882.nschichan@freebox.fr>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 07 September 2007 23:16:35 Benedict, Michael wrote:
> What version of U-boot are you using?

Until recently I was using the u-boot-1.2.0 available on the 
ftp://ftp.denx.de/pub/u-boot/ apparently there since january 2007.

I now use the git tree of today, and everything seems to work fine. I dit not 
notice any freeze or random panic. "stress --cpu 256" is running on the board 
and after 10 minutes it is still alive.

Thank you for the hint :)

Regards,

-- 
Nicolas Schichan
