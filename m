Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 1463E67BFF
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Nov 2006 07:01:57 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Tue, 28 Nov 2006 21:01:52 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Message-ID: <20061128200152.16610@gmx.net>
MIME-Version: 1.0
Subject: DEFAULT_CUIMAGE supported already in arch/powerpc?
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I wonder, if the DEFAULT_CUIMAGE target is already supported in the lastest kernel source code (>=2.6.18). I couldn't found any references to it in 2.6.18, but it would be useful for porting the AmigaOne platform code to the powerpc architecture.
Unfortunately I couldn't get in contact with the main developer of the AmigaOne U-boot firmware yet. This makes the DEFAULT_CUIMAGE target the only viable solution, because the U-boot firmware used in the A1 is too old to support device trees and the current platform init code needs access to the bd_t structure (thus zImage doesn't work too - correct me, if I'm wrong).

Any information about this?

Regards,

Gerhard

-- 
Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! 
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
