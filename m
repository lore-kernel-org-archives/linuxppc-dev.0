Return-Path: <stephane.fillod@thomson.net>
Received: from dmzraw3.extranet.thmulti.com (unknown [141.11.234.71])
	by ozlabs.org (Postfix) with ESMTP id B69DBDDF69
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Mar 2008 00:21:31 +1100 (EST)
Received: from boulvss3.eu.thmulti.com (unknown [141.11.234.56])
	by dmzraw3.extranet.thmulti.com (Postfix) with ESMTP id 6C52D2AD6
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Mar 2008 13:04:21 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by boulvss3.eu.thmulti.com (Postfix) with ESMTP id 3BAF711F0
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Mar 2008 13:11:25 +0000 (GMT)
Received: from boulvss3.eu.thmulti.com ([127.0.0.1])
	by localhost (boulvss3.eu.thmulti.com [127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 27197-02-73 for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Mar 2008 13:11:13 +0000 (GMT)
Received: from boulsmailfe02.eu.thmulti.com (boulasmtp.eu.thmulti.com
	[141.11.196.14])
	by boulvss3.eu.thmulti.com (Postfix) with ESMTP id 610D91218
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Mar 2008 13:11:13 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: HugeTLB on MPC 85xx ?
Date: Wed, 5 Mar 2008 14:04:08 +0100
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7AD381AA@rennsmail04.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
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

Hi,

Most of you know already about HugeTLB
(Documentation/vm/hugetlbpage.txt).

Is there any plan of HugeTLB support for the MPC 85xx platform?
This is IMO an important feature missing in Linux for those great SoC.
Would any 4K assumption in the kernel be a showstopper for HugeTLB?

On a similar SoC, is there any status about "Huge-page support for
ppc440"?
 http://thread.gmane.org/gmane.linux.ports.ppc.embedded/14814

Thanks
--=20
Stephane
