Return-Path: <Joakim.Tjernlund@lumentis.se>
Received: from dmz.lumentis.net (unknown [212.105.56.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 77B2967A7F
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Apr 2005 07:51:56 +1000 (EST)
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: <marcelo.tosatti@cyclades.com>, <linuxppc-embedded@ozlabs.org>
Date: Tue, 5 Apr 2005 23:51:42 +0200
Message-ID: <BCEFJBPJCGFCNMMMIDBHEEFNCLAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: 8xx v2.6 TLB problems and suggested workaround
Reply-To: Joakim.Tjernlund@lumentis.se
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Marcelo

Reading your report it doesn't sound likely but I will ask anyway:
Is it possible that the problem you are seeing isn't caused by the
"famous" CPU bug mentioned here: 
http://ozlabs.org/pipermail/linuxppc-embedded/2005-January/016351.html

The DTLB error handler needs DAR to be set correctly and since the
dcbX instructions doesn't set DAR in either DTLB Miss nor DTLB Error you
may end up trying to fix the wrong address.

   Jocke
