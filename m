Return-Path: <roland@digitalvampire.org>
Received: from sccrmhc13.comcast.net (sccrmhc13.comcast.net [204.127.202.64])
	by ozlabs.org (Postfix) with ESMTP id 4262A67C8E
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Jul 2005 13:57:19 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by hellmouth.digitalvampire.org (Postfix) with ESMTP id E157065C05
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Jul 2005 20:52:01 -0700 (PDT)
Received: from hellmouth.digitalvampire.org ([127.0.0.1])
	by localhost (hellmouth.attbi.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 03360-01 for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Jul 2005 20:51:33 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.1.0.8])
	by hellmouth.digitalvampire.org (Postfix) with ESMTP id 7F41065C02
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Jul 2005 20:51:28 -0700 (PDT)
To: linuxppc-embedded@ozlabs.org
From: Roland Dreier <roland@digitalvampire.org>
Date: Tue, 05 Jul 2005 20:51:27 -0700
Message-ID: <873bqsbni8.fsf@love-shack.home.digitalvampire.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: AMCC 440SPe support?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Are patches to support the AMCC PowerPC 440SPe processor available?
Mainline 2.6 apparently does not contain anything related to the
440SPe.  We're planning on using the 440SPe in a project, and I'm
wondering if I'll have to do the bringup myself.

If no one has released this yet, I'll be happy to start posting
patches once my eval boards arrive.  I just don't want to duplicate
effort if someone has already brought up Linux on the 440SPe.

Thanks,
  Roland
