Return-Path: <edjubenville@adelphia.net>
Received: from mta10.adelphia.net (mta10.adelphia.net [68.168.78.202])
	by ozlabs.org (Postfix) with ESMTP id 9DA9C67A65
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Mar 2005 01:29:24 +1100 (EST)
Received: from EJ1 ([69.166.195.214]) by mta10.adelphia.net
	(InterMail vM.6.01.04.01 201-2131-118-101-20041129) with SMTP
	id <20050314142919.DQKO7277.mta10.adelphia.net@EJ1>
	for <linuxppc-embedded@ozlabs.org>; Mon, 14 Mar 2005 09:29:19 -0500
From: "Edward Jubenville" <edjubenville@adelphia.net>
To: <linuxppc-embedded@ozlabs.org>
Date: Mon, 14 Mar 2005 06:29:19 -0800
Message-ID: <GPECLCIGPLHEOMGPMCPAGEILCMAA.edjubenville@adelphia.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: ELDK 3.1 installation tells me "Wrong format of the  rpm archive"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I tried installing ELDK 3.1 on RedHat 9,
but all I got was this:

   Installing cross RPMs
   Wrong format of the  rpm archive.

I'm a rookie, so I'm sure I screwed something up. I had downloaded
the ISO image to my Windows PC, made the CD there, copied the tree
onto my Linux box at /ELDKCD, then tried:

	./install -d /ELDK
and
	./install -d /ELDK ppc_6xx

What did I do wrong?
