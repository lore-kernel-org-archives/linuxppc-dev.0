Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 056C8B70E7
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Dec 2010 01:49:21 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 11399-10 for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  6 Dec 2010 14:49:15 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Getting the IRQ number (Was: Basic driver devel questions ?)
Date: Mon, 6 Dec 2010 14:47:59 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8ABEA@saturn3.aculab.com>
In-Reply-To: <201012061544.40124.dargaud@lpsc.in2p3.fr>
From: "David Laight" <David.Laight@ACULAB.COM>
To: <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> Another question: I just spent 10 minutes trying to find
> where "struct device" was defined.

Dirty trick #4:

At the top of a source file (before the first include) add:
    struct device { int fubar; };
Then try to compile it.

The compiler will the tell where it is defined!

	David
