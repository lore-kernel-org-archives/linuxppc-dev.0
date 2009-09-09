Return-Path: <michaelbarkowski@ruggedcom.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1363AB7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Sep 2009 23:26:20 +1000 (EST)
Received: from mail.ruggedcom.com (mail.ruggedcom.com [204.50.190.93])
	by ozlabs.org (Postfix) with ESMTP id 5A956DDD04
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Sep 2009 23:26:17 +1000 (EST)
Received: from [10.200.19.236] (unknown [10.200.19.236])
	by rceng01.eng.lan (Postfix) with ESMTP id 0C74314E817
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Sep 2009 09:26:15 -0400 (EDT)
Message-ID: <4AA7ACF6.6040703@ruggedcom.com>
Date: Wed, 09 Sep 2009 09:26:14 -0400
From: Michael Barkowski <michaelbarkowski@ruggedcom.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: pq2 pro: kgdb access to MURAM?
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Just wondering how I can get kgdb to show me the contents of MURAM on the QE?

-- 
Michael Barkowski
905-482-4577
