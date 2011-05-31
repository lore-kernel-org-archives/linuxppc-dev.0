Return-Path: <mpearson@ca.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1C729B6F73
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jun 2011 01:51:33 +1000 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e3.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p4VFTGSS021150
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2011 11:29:16 -0400
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p4VFpRhn1216610
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2011 11:51:27 -0400
Received: from d01av05.pok.ibm.com (loopback [127.0.0.1])
	by d01av05.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p4VFpQnD022185
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2011 11:51:26 -0400
Received: from d01ml393.pok.ibm.com (d01ml393.pok.ibm.com [9.63.10.39])
	by d01av05.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p4VFpQ8m022182
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2011 11:51:26 -0400
Subject: Using the BDI3k with the P4040
To: linuxppc-dev@lists.ozlabs.org
Message-ID: <OF833AC6C3.41FF7523-ON852578A1.005661D8-852578A1.0056B897@ca.ibm.com>
From: Mark Pearson <mpearson@ca.ibm.com>
Date: Tue, 31 May 2011 11:47:13 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

Apologies if this is the wrong forum for this message but I figured it was
a good place to start.

We have a new P4040 based board and are having lots of fun trying to get
our BDI3k to work with it. The BDI isn't able to get control/halt the
processor. I can go into more details if anybody is really interested but I
was mainly interested if anybody had tried this combo before and if they
knew of any gotcha's, example BDI configs etc.

At the moment suspecting HW issue around the reset but of course the HW
team would like us to check that we're not doing dumb things from the
SW/BDI side of things too.

Thanks in advance

Mark Pearson
