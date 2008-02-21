Return-Path: <gerickson@nuovations.com>
Received: from relay03.pair.com (relay03.pair.com [209.68.5.17])
	by ozlabs.org (Postfix) with SMTP id A882CDDE45
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Feb 2008 11:24:45 +1100 (EST)
Date: Wed, 20 Feb 2008 16:24:27 -0800
Subject: ALLMULTI Required for Avahi on Kilauea/Haleakala
From: Grant Erickson <gerickson@nuovations.com>
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Message-ID: <C3E204BB.D834%gerickson@nuovations.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am working on getting avahi-daemon along with nss-mdns up and running on
an the AMCC Kilauea/Haleakala development boards and noted that in order for
other systems to discover it and vice versa, ALLMULTI has to be enabled on
'eth0'. 

Is this a known works-as-designed aspect of the IBM new_emac driver or a
TBD/WIP implementation issue in the driver?

Regards,

Grant
