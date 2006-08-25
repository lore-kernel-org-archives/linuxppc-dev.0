Return-Path: <GSM909@gmx.de>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id C166367B62
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Aug 2006 22:19:51 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Fri, 25 Aug 2006 14:19:47 +0200
From: "Keinen Namen" <GSM909@gmx.de>
Message-ID: <20060825121947.88490@gmx.net>
MIME-Version: 1.0
Subject: m8260_cpm_dpalloc -> m8260_cpm_dpfree ?
To: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

Simple Question, I allocate Memory for my BDs with m8260_cpm_dpalloc, but there are no dpfree in Linux 2.4.25. In Linux 2.6 are a funktion to free dp memory.

Are there no funktion in Linux 2.4 ? 

Regards
Fred
-- 


Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
