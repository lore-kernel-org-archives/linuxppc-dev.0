Return-Path: <rlefevre@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id D84DEDDF11
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Sep 2008 09:54:03 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m33so1186944wag.9
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 29 Sep 2008 16:54:02 -0700 (PDT)
Message-ID: <4e0b9cb00809291654j54d80f3agea463591a139b835@mail.gmail.com>
Date: Tue, 30 Sep 2008 01:54:02 +0200
From: "Remi Lefevre" <rlefevre@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Problem with flush_icache_range, linux-2.6.27-rc7-denx & mpc8270
In-Reply-To: <4e0b9cb00809230832r47904417xc4eb5b3159f4f21f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4e0b9cb00809230832r47904417xc4eb5b3159f4f21f@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

For archives, it was due to SDRAM configuration.
See the following U-Boot thread for more details:

http://lists.denx.de/pipermail/u-boot/2008-September/041092.html

Regards,
R=E9mi
