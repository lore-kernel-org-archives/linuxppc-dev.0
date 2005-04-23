Return-Path: <Joakim.Tjernlund@lumentis.se>
Received: from dmz.lumentis.net (unknown [212.105.56.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2AC3167A6B
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Apr 2005 03:24:01 +1000 (EST)
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: <linuxppc-embedded@ozlabs.org>, <marcelo.tosatti@cyclades.com>
Date: Sat, 23 Apr 2005 19:23:51 +0200
Message-ID: <BCEFJBPJCGFCNMMMIDBHMEIHCLAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [26-devel] v2.6 performance slowdown on MPC8xx: Measuring TLB
	cache misses
Reply-To: Joakim.Tjernlund@lumentis.se
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Now, what is the best way to bring the performance back to v2.4 levels? 
> 
> For this "dd" test, which is dominated by "sys_read/sys_write", I thought 
> of trying to bring the hotpath functions into the same pages, thus
> decreasing the number of page translations required for such tasks.
> 
> Comments are appreciated

Does CONFIG_PIN_TLB make a difference?

 Jocke
