Return-Path: <stephane.fillod@thomson.net>
Received: from dmzraw2.extranet.tce.com (dmzraw2.extranet.tce.com
	[157.254.234.138]) by ozlabs.org (Postfix) with ESMTP id 9B64A67A82
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Apr 2005 01:09:13 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 5 Apr 2005 17:08:59 +0200
Message-ID: <1CFEB358338412458B21FAA0D78FE86D4F0D2D@rennsmail02.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
To: "Chris Friesen" <cfriesen@nortel.com>
Cc: linuxppc-dev@ozlabs.org
Subject: RE: somewhat OT -- trying to build code on the fly then run it
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Chris Friesen wrote:=20
> I'm writing a testcase to test some code we wrote to allow userspace
to=20
> flush the whole dcache and invalidate the whole icache. =20

Your testcase sounds like this kernel module for RT load generator:

	http://rtai.dk/cgi-bin/gratiswiki.pl?Latency_Killer/Flushy


Comments welcome.
--=20
Stephane
