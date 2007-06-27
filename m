Return-Path: <dbeamonte@telnet-ri.es>
Received: from correo.efor.es (62.81.153.195.static.user.ono.com
	[62.81.153.195]) by ozlabs.org (Postfix) with ESMTP id 36A55DDF0A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Jun 2007 19:10:22 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by leela.efor.es (Postfix) with ESMTP id 5602E2FA981
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Jun 2007 10:50:39 +0200 (CEST)
Received: from [192.168.200.117] (101.Red-81-33-23.staticIP.rima-tde.net
	[81.33.23.101]) by leela.efor.es (Postfix) with ESMTP id 986462FA9CF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Jun 2007 10:50:38 +0200 (CEST)
Message-ID: <468224AB.7040004@telnet-ri.es>
Date: Wed, 27 Jun 2007 10:49:47 +0200
From: David <dbeamonte@telnet-ri.es>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: USB for MPC82xx
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I know this is a quite old issue but I'm getting quite crazy with it and 
I hope that someone can help me.

The plot is that I'm trying to use USB on an MPC8272. I already know 
that there is a 2.6.x driver that solves this, but the main issue is 
that we are using a 2.4.31 kernel. So we have

I have read a lot about a 2.4 driver that Pantelis Antoniou wrote, but I 
haven't been able to find it.

Does anybody know where I could find a driver?

The other option is to backport the 2.6 driver to 2.4, but I will try 
not to think on that by the moment.

Regards,

David
