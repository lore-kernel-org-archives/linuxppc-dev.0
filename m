Return-Path: <aris@cathedrallabs.org>
Received: from tinc.cathedrallabs.org (tinc.cathedrallabs.org [72.9.252.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5A02467B4C
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jun 2006 00:04:40 +1000 (EST)
Received: from tate.cathedrallabs.org
	(201-25-166-92.ctame704.dsl.brasiltelecom.net.br [201.25.166.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by tinc.cathedrallabs.org (Postfix) with ESMTP id 19D721000A
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jun 2006 09:35:01 -0400 (EDT)
Date: Wed, 28 Jun 2006 10:34:53 -0300
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
To: linuxppc-dev@ozlabs.org
Subject: backlight control broken in current Linus' and Paulus' trees
Message-ID: <20060628133453.GA14876@cathedrallabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,
	the backlight control is broken in my PowerBook6,8 in latest git
	trees, both for pbbuttonsd (yes, I have CONFIG_PMAC_BACKLIGHT_LEGACY
	enabled) and for fblevel. the last one also allows values be set
	at least to 1000 and according to new code, it should be able to
	reach 127. I gathered some information in
		http://www.cathedrallabs.org/~aris/backlight/
	if I can provide any other information or help in testing,
	please let me know.

-- 
Aristeu
