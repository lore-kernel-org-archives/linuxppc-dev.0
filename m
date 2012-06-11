Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6C1D1B6FC3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2012 05:26:05 +1000 (EST)
Received: from mail1.transmode.se (mail1.transmode.se [192.168.201.18])
 by gw1.transmode.se (Postfix) with ESMTP id 43018258135
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jun 2012 21:16:44 +0200 (CEST)
Subject: reserving memory using OF rsvmap feature?
To: linuxppc-dev@lists.ozlabs.org
Message-ID: <OFDFDC3B6C.CE37E2BC-ONC1257A1A.00698754-C1257A1A.0069E657@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 11 Jun 2012 21:16:42 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Is it possible to reserve some memory using OF rsvmap such that Linux
will not touch this area at all? Think of is as warm start stash area
were one could store data which should survive a reboot.

One could then create an uio driver which exports this memory to user space I hope.

 Jocke
