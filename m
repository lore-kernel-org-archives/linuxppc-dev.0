Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E11ADDDE26
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Aug 2007 02:33:11 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l73GX84g004864
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 12:33:08 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l73GX8CP268314
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 10:33:08 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l73GX81A013246
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 10:33:08 -0600
Message-Id: <20070803160900.069522000@linux.vnet.ibm.com>>
Date: Fri, 03 Aug 2007 11:09:00 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: [patch 00/10] 4xx patch series for 2.6.24
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here are the current 4xx patches I'd like to get in to 2.6.24.  They include
some initial cleanups for 40x support as well as the AMCC Bamboo board support.

If we can get Bamboo merged, that will make it much easier for Sequoia (440EPx)
and Rainer (440GRx) to follow on.

Also, I've started a git tree for 4xx work.  It contains these patches on the
for-2.6.24 branch.  If you do

git pull \
git://git.infradead.org/users/jwboyer/powerpc.git for-2.6.24

You should get this entire series.  It is currently based off of Paul's latest
tree.

josh

-- 
