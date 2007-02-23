Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id AFFECDDE3E
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Feb 2007 02:20:04 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: cpm_dpalloc and m8xx_cpm_dpalloc are interchangeable?
Date: Fri, 23 Feb 2007 16:20:02 +0100
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E6829E6@aquib01a>
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8E68299F@aquib01a>
From: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
To: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Subject: cpm_dpalloc and m8xx_cpm_dpalloc are interchangeable?

I think they are not interchangeable, you should use cpm_dpram_addr to
get the real address where to put your buf descriptors.

Bye,.
