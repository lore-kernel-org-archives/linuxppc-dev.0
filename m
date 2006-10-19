Return-Path: <boris@fabiotec.com>
Received: from mtaout1.barak.net.il (mtaout1.barak.net.il [212.150.49.171])
	by ozlabs.org (Postfix) with ESMTP id 76C9967B8D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Oct 2006 02:05:57 +1000 (EST)
Received: from [192.168.200.97] ([62.90.35.117])
	by mtaout1.barak.net.il (Sun Java System Messaging Server 6.2-6.02
	(built Apr
	25 2006)) with ESMTPA id <0J7E00HDJ4PUII00@mtaout1.barak.net.il> for
	linuxppc-embedded@ozlabs.org; Thu, 19 Oct 2006 18:05:55 +0200 (IST)
Date: Thu, 19 Oct 2006 18:05:55 +0200
From: Boris Shteinbock <boris@fabiotec.com>
Subject: Re: [PATCH] CPM_UART: Fix non-console transmit
To: linuxppc-embedded@ozlabs.org
Message-id: <4537A263.3010104@fabiotec.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kalle.

After applying your patch,
the transmission doesn't take place at all..
just hanging in write...
at least it is possible to exit the program.
