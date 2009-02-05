Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id D8A1FDDDDB
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Feb 2009 00:36:54 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Thu, 05 Feb 2009 14:36:51 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <1233780436.4612.0.camel@pasglop>
Message-ID: <20090205133651.81040@gmx.net>
MIME-Version: 1.0
References: <20090202212139.69160@gmx.net>  <20090202213910.258290@gmx.net>	
	<1233719407.16867.164.camel@pasglop>  <20090204120928.102380@gmx.net>
	<1233780436.4612.0.camel@pasglop>
Subject: [RFC] Error handling in *_add/find_bridges()
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi!

I have a minor question about the error handling in the various *_add/find_bridges functions, which are used to detect and initialize
PHBs. AFAIK all of them return an error code that is never checked in
the platform setup code (e.g. when there is no memory for the
pci_controller struct).
Shouldn't the kernel panic (BUG();), when it can't initialize the PHB
for whatever reason and the platform depends on a working PCI bus?

Thanks!

regards,

Gerhard
-- 
Jetzt 1 Monat kostenlos! GMX FreeDSL - Telefonanschluss + DSL 
für nur 17,95 Euro/mtl.!* http://dsl.gmx.de/?ac=OM.AD.PD003K11308T4569a
