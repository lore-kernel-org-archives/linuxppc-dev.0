Return-Path: <Matteo.Fortini@mta.it>
Received: from dig-mailtc.digitek.int (mail-dgt.mta.it [93.63.228.226])
	by ozlabs.org (Postfix) with ESMTP id 06A94DDFAD
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jan 2009 22:31:05 +1100 (EST)
Message-ID: <497D9EF1.4030403@mta.it>
Date: Mon, 26 Jan 2009 12:30:57 +0100
From: Matteo Fortini <matteo.fortini@mta.it>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Booting uncompressed kernel image
Content-Type: text/plain; charset="ISO-8859-15"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,
I built an uncompressed uImage using mkimage --no-gzip -C none in the
wrapper scripts.

Only, u-boot recognizes it as uncompressed and launches the kernel
properly (it's around 4MB), but in the end linux just prints
OK
and stops.

Has anyone done the same?

Thanks ,
Matteo
