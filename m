Return-Path: <TNghiem@oerlikon.ca>
Received: from mail.oerlikon.ca (unknown [205.233.198.228])
	by ozlabs.org (Postfix) with ESMTP id DFBF12BEA0
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Nov 2004 08:43:24 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Tue, 2 Nov 2004 16:31:06 -0500
Message-ID: <AE20493C16DE7F46BC29B257C8D708D3202B4F@mail.oerlikon.ca>
From: "Nghiem, Tien" <TNghiem@oerlikon.ca>
To: "linuxppc-dev list" <linuxppc-dev@ozlabs.org>
Subject: PCI's clock on Lite5200
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Everyone,

I have successfully boot Linux 2.4.22 on my Lite5200 Evaluation Board =
with the ELDK, the PCI's clock is 66MHz. I would like to change it to =
33MHz. The register to be modified is the CDM register but I cannot =
found where I can modify it in the source code. Could anyone tell me =
where it is?

Thank you

Tien Nghiem
Software Developer

Oerlikon Contraves Inc.
225, Boul.Seminaire Sud
St-Jean-sur-Richelieu(Quebec)
J3B 8E9

Tnghiem@oerlikon.ca
