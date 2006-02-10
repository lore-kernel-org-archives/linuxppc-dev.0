Return-Path: <pnasrat@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 87619679EF
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Feb 2006 13:28:59 +1100 (EST)
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com
	[172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id k1A2Swam026400
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Feb 2006 21:28:58 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id k1A2Sv104579
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Feb 2006 21:28:57 -0500
Received: from vpn83-127.boston.redhat.com (vpn83-127.boston.redhat.com
	[172.16.83.127])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id k1A2SvQo008222
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Feb 2006 21:28:57 -0500
Subject: yaboot 1.3.14 release candidate 1
From: Paul Nasrat <pnasrat@redhat.com>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Thu, 09 Feb 2006 21:28:58 -0500
Message-Id: <1139538538.3638.14.camel@enki.eridu>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It's been some time in the making but I'd like to put out what is on
HEAD for people to test. Key features are improved netbooting on IBM
pSeries machines (Nathan Lynch), Amiga partition support (Sven Luther),
Software RAID support on IBM pSeries machines (Dustin Kirkland), plus
many small fixups. Thanks to all the contributors involved. It should be
listed in the snapshot section at http://yaboot.ozlabs.org/

c955afa8188dcb927db09cb30e82cef0c00dbedb  yaboot-1.3.14rc1.tar.gz

Most of the stuff is already in a variety of distributions, but I'd
invite wider testing.

Thanks to ozlabs for putting up the hosting at short notice when
penguinppc.org had hardware issues.

Paul
