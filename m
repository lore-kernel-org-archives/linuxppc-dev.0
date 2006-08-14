Return-Path: <matt@genesi-usa.com>
Received: from mail.genesippc.com (mithrandir.softwarenexus.net [66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 93F2567BC4
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 21:51:01 +1000 (EST)
From: "Matt Sealey" <matt@genesi-usa.com>
To: "'Paul Mackerras'" <paulus@samba.org>,
	"'Albert Cahalan'" <acahalan@gmail.com>
Subject: RE: PowerPC paxtest results w/ gcc-4.1
Date: Mon, 14 Aug 2006 13:50:53 +0200
Message-ID: <000301c6bf97$e9151e00$99dfdfdf@bakuhatsu.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <17630.27174.711916.643790@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
Reply-To: matt@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



> Of course, that won't make all that much difference on your 
> Cube, because the G4 CPU doesn't have hardware support for 
> non-executable pages (any readable page is executable)

I don't think this is true?

Book I compatible PowerPC's have had a "no-executable" bit in
the page protection flags since the dark ages.. see page 7-38
and 7-39 of the 'Programming Environments Manual for 32-Bit
Microprocessors'.. this document predates even the G3.

As far as the documentation goes, you can make the page
readable and writable to the LSU, but the N bit causes the
instruction fetch to cause a machine check. That's pretty
"not-executable" to me at least :)

-- 
Matt Sealey <matt@genesi-usa.com>
Manager, Genesi, Developer Relations
