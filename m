Return-Path: <Martin.Krause@tqs.de>
Received: from mail.tqs.de (mail.tqs.de [213.68.230.225])
	by ozlabs.org (Postfix) with ESMTP id 92C062BF07
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Dec 2004 04:20:25 +1100 (EST)
Received: from tq-mailsrv-1.tq-net.de (tq-mailsrv-1 [172.20.1.1])
	by mail.tqs.de (Postfix) with ESMTP id D59FA3C1C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Dec 2004 18:20:14 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 22 Dec 2004 18:20:14 +0100
Message-ID: <DE2CC66C40EAB74EA6D66AC71BF98E1E03055B12@TQ-MAILSRV-1>
From: "Martin Krause" <Martin.Krause@tqs.de>
To: <achim.machura@berghof.com>
Cc: "Linuxppc-Embedded \(E-Mail\)" <linuxppc-embedded@ozlabs.org>
Subject: AW: BestCommApi on MPC5200
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Achim,

Achim Machura wrote on Mittwoch, 22. Dezember 2004 15:22:
> I work on a 5200 board and want to enable an Bestcomm-task to copy
> Data from PSC to a shared memory.
> Have anyone an example for doing this?

There is a BestComm API user guide. Maybe this is helpful.
You could find it in the linuxppc_2_4_devel linux source
tree from denx CVS-Server (look at www.denx.de -> Software):

linuxppc_2_4_devel\arch\ppc\5xxx_io\bestcomm\doc\BestCommAPIUserGuide.pdf=


If you want, I could send the document to you without CC to the
linuxppc-embedded list (because it is about 120 kByte).

Regards,
Martin
