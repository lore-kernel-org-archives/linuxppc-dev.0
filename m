Return-Path: <dibacco@inwind.it>
Received: from smtp8.libero.it (smtp8.libero.it [193.70.192.92])
	by ozlabs.org (Postfix) with ESMTP id 32B7D68A1E
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Feb 2006 09:24:40 +1100 (EST)
Received: from localhost (172.16.1.79) by smtp8.libero.it (7.0.027-DD01)
	id 43E11EB30087F385 for linuxppc-embedded@ozlabs.org;
	Tue, 7 Feb 2006 23:24:39 +0100
Received: from smtp2.libero.it ([172.16.1.97])
	by localhost (asav1.libero.it [193.70.192.150]) (amavisd-new,
	port 10024)
	with ESMTP id 18823-15-2 for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Feb 2006 23:24:38 +0100 (CET)
Received: from libero.it (172.16.1.114) by smtp2.libero.it (7.0.027-DD01)
	id 431C3B20019F43B2 for linuxppc-embedded@ozlabs.org;
	Tue, 7 Feb 2006 23:24:38 +0100
Date: Tue,  7 Feb 2006 23:24:38 +0100
Message-Id: <IUC8X2$BBAE28486C091C5CAA95431276FDABE5@libero.it>
Subject: MPC875 using SCC4 together with both FECs
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "dibacco\@inwind\.it" <dibacco@inwind.it>
To: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Someone knows if, in MPC875, SCC4 can be used together with the two FECs?=
 I saw that RXD4(input SCC4) shares the same GPIO with MII-TXD0 (output o=
f FEC0).

Thank you,
Antonio.
