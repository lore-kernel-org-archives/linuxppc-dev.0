Return-Path: <mgberry@ellipticity.com>
Received: from waffle.digitalsmiths.com (waffle.digitalsmiths.com
	[66.194.119.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "plesk", Issuer "plesk" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7F83567C28
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Jul 2005 01:46:32 +1000 (EST)
Message-ID: <20050711113948.vznzvgxu15nkkwcg@webmail.ellipticity.com>
Date: Mon, 11 Jul 2005 11:39:48 -0400
From: mgberry@ellipticity.com
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
Subject: MPC5200 Rev. B
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Has anyone experienced any issues with the Rev. B silicon for the MPC5200.  We
are seeing Linux hanging and are suspecting the SDRAM errata for Rev. B.  If we
disable the cache this seems to improve but will still crash over time in heavy
loads.  We have not seen any of these type issues with the original rev.

Matt
