Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id 2B5C4DDEEF
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Mar 2007 22:08:12 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: static immap_t   __iomem *imap    or   immap_t *imap;
Date: Tue, 6 Mar 2007 12:08:09 +0100
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E6C0AA8@aquib01a>
From: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Why should I use
static immap_t   __iomem *imap;
And not
immap_t *imap;
in a driver?
when imap =3D ioremap_nocache()

In particular I know that __iomem is useful to the compiler to avoid
reordering and delaying io memory writes but what's the need for static
in this case?
