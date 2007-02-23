Return-Path: <ray.clouse@boeing.com>
Received: from blv-smtpout-01.ns.cs.boeing.com (blv-smtpout-01.boeing.com
	[130.76.32.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "blv-smtpout-01.boeing.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A1270DDDFC
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Feb 2007 09:19:26 +1100 (EST)
Received: from blv-av-01.boeing.com (blv-av-01.boeing.com [192.42.227.216])
	by blv-smtpout-01.ns.cs.boeing.com (8.13.6/8.13.6/TEST_SMTPIN) with
	ESMTP id l1NLflLA014994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Feb 2007 13:41:48 -0800 (PST)
Received: from blv-av-01.boeing.com (localhost [127.0.0.1])
	by blv-av-01.boeing.com (8.13.6/8.13.6/DOWNSTREAM_RELAY) with ESMTP id
	l1NLflP0014623 for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Feb 2007 13:41:47 -0800 (PST)
Received: from xch-swbh-11.sw.nos.boeing.com (xch-swbh-11.sw.nos.boeing.com
	[129.172.192.157])
	by blv-av-01.boeing.com (8.13.6/8.13.6/UPSTREAM_RELAY) with ESMTP id
	l1NLfkvH014588 for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Feb 2007 13:41:47 -0800 (PST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: How to disable NFS & FTP (xinetd) on startup?
Date: Fri, 23 Feb 2007 13:41:46 -0800
Message-ID: <BBE853677EFE3F4E98AE8011DE7D66B702236728@XCH-SW-1V2.sw.nos.boeing.com>
From: "Clouse, Ray" <ray.clouse@boeing.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm configuring an ELDK install I've inherited.  I need to keep NFS and
xinetd from running during boot.  After checking some things I'll start
them instead in rc.local. =20

In Fedora Core I'd use chkconfig to turn them off but ELDK doesn't have
that.

How can I disable NFS and xinetd?

--
Ray Clouse
MSHP Embedded S/W Engineer
ray.clouse@boeing.com
