Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id D6D9BDDE02
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 07:34:28 +1000 (EST)
Received: from lyakh (helo=localhost)
	by poirot.grange with local-esmtp (Exim 3.36 #1 (Debian))
	id 1IAYD3-00032H-00
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 23:34:25 +0200
Date: Mon, 16 Jul 2007 23:34:25 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: of_flat_dt_is_compatible() scope Q
Message-ID: <Pine.LNX.4.60.0707162329370.4488@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi

Just noticed, that of_flat_dt_is_compatible() is only ever used with node 
= of_get_flat_dt_root(). So, unless we ever plan to use it otherwise, 
someone might want to simplify it a bit:-)

Thanks
Guennadi
---
Guennadi Liakhovetski
