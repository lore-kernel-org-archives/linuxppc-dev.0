Return-Path: <kallepokki@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by ozlabs.org (Postfix) with ESMTP id 5CBBDDDEF5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Feb 2008 02:04:10 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so3914942wag.13
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Feb 2008 07:03:51 -0800 (PST)
Message-ID: <a425f86c0802200703x6cbbd5acwa4b3a8dda455eeea@mail.gmail.com>
Date: Wed, 20 Feb 2008 17:03:50 +0200
From: "Kalle Pokki" <kalle.pokki@eke.fi>
Sender: kallepokki@gmail.com
To: linuxppc-embedded@ozlabs.org, wd@denx.de
Subject: ELDK on 64-bit host
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I tried to copy the ELDK 4.0 installation I had to a new Core 2 Quad
machine running 64-bit Ubuntu 7.10, but the new machine refuses to
execute the cross compiler. Has anyone succeeded in running ELDK in
this kind of environment?

I also tried compiling the ELDK from source RPMs as described in the
documentation, but at least some of the RPMs the scripts try to
download are no longer available on the net, and the build environment
described doesn't seem to quite match the one on the source rpm ISO
image.
