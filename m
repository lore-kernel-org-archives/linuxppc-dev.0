Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C8BDBB6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Dec 2010 23:46:19 +1100 (EST)
Received: from lpsc0174x.localnet (lpsc0174x.in2p3.fr [134.158.40.174])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id
	oB7CkDHG027250
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Dec 2010 13:46:14 +0100
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Getting the IRQ number (Was: Basic driver devel questions ?)
Date: Tue, 7 Dec 2010 13:46:13 +0100
References: <201012011115.00960.dargaud@lpsc.in2p3.fr>
	<201012031558.35557.dargaud@lpsc.in2p3.fr>
	<1291613340.11896.216.camel@concordia>
In-Reply-To: <1291613340.11896.216.camel@concordia>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201012071346.13434.dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael, 
in your example, when is foo_driver_probe() actually called ?
It's not being called when I do an insmod.
-- 
Guillaume Dargaud
http://www.gdargaud.net/
