Return-Path: <Simon.Richter@hogyros.de>
Received: from psionic8.psi5.com (psionic.psi5.com [212.112.229.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.psi5.com", Issuer "psi5.com CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id BA7ADB7BA5
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Dec 2009 22:55:32 +1100 (EST)
Received: from localhost (port-212-202-168-87.dynamic.qsc.de [212.202.168.87])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client CN "Simon Richter",
	Issuer "CA Cert Signing Authority" (verified OK))
	by psionic8.psi5.com (Postfix) with ESMTPS id F2960F2C016
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Dec 2009 12:45:42 +0100 (CET)
Date: Fri, 11 Dec 2009 12:45:43 +0100
From: Simon Richter <Simon.Richter@hogyros.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: AltiVec in the kernel
Message-ID: <20091211114543.GF24650@honey.hogyros.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

since there has been a thread on allowing the use of a coprocessor in
the kernel already: I am wondering if it'd make sense to use AltiVec for
AES in dm-crypt, and how difficult it would be to implement that.

I'm using a PegasosII which has a G4 running at 1 GHz; I get around 3
MB/s throughput when accessing harddisks. I think that could be
improved.

If I understand correctly, the actual encryption work runs in a kernel
thread, which is scheduled normally, so it ought to be possible to
enable AltiVec for that thread; am I missing something here?

   Simon
