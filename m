Return-Path: <i2a@gmx.net>
Received: from vmx15.multikabel.net (vmx15.multikabel.net [212.127.254.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1DF1068646
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Oct 2005 11:36:04 +1100 (EST)
Received: from vmx100.multikabel.net ([212.127.254.147])
	by vmx15.multikabel.net with esmtp (Exim 4.44) id 1EWNeU-0005Ll-G1
	for linuxppc-dev@ozlabs.org; Mon, 31 Oct 2005 01:35:54 +0100
Received: from sun.nodomain.nl (84-104-47-99.cable.quicknet.nl [84.104.47.99])
	by vmx100.multikabel.net (8.13.3/8.13.3) with ESMTP id j9V0ZkXE012799
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Oct 2005 01:35:52 +0100
From: "Ingmar" <i2a@gmx.net>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Date: Mon, 31 Oct 2005 01:35:49 +0100
Message-Id: <20051031002926.M71008@quicknet.nl>
In-Reply-To: <1130645036.29054.229.camel@gaston>
References: <1130645036.29054.229.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Subject: exception vectors
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

I am trying to overwrite the exception vector space of an ibook G4 :).

I have set up (for every exception) a small piece of code, that's a prefix of a
handler to be called. My problem is, that writing the “small” chunks of code to
the exception vector space gives no problem(so it seams) but writing all the
pieces of code as one chunk gives a exception [dsi, dsisr 0x42000000], this
indicates a store problem.

I have tried different modes of copying, mmu on/off, also chanced the WING bit,
switched the exception prefix on.

I don't believe putting the exception vectors to there “place” one by one is the
right way, in the Linux kernel the kernel get relocated and the code comes into
place. I have taken this as an example, unfortunately to to result :(..

 - Am I overlooking something?
 - Is the a “standard way” to overwrite the exception vector space of a powerpc?

ThankZ,
  Ingmar
