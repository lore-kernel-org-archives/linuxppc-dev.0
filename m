Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 9B40FDE1A3
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 23:05:39 +1000 (EST)
Date: Fri, 11 Apr 2008 17:05:37 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/2] Notorious OF GPIO API support
Message-ID: <20080411130537.GA10608@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org, David Miller <davem@davemloft.net>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Paul,

Please consider applying these patches for the 2.6.26. Pretty much of
new drivers depend on this support, including some of my patches and
patches from Jochen Friedrich and Laurent Pinchart.

My plan is to submit MPC83xx/MPC85xx specific parts to Kumar after these
two applied. Then I'll submit pending USB/I2C/MTD/... drivers to the
appropriate subsystem maintainers.

For those who didn't follow these patches, here is recall of the
previous discussions:
http://ozlabs.org/pipermail/linuxppc-dev/2007-December/047948.html
http://ozlabs.org/pipermail/linuxppc-dev/2007-December/048788.html
http://ozlabs.org/pipermail/linuxppc-dev/2008-January/049414.html
http://ozlabs.org/pipermail/linuxppc-dev/2008-March/052881.html

Since January I resent these patches about two or three times just with
some cosmetic changes because of no further comments on the design, so I
believe that interested parties are more or less satisfied with it now.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
