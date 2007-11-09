Return-Path: <mikenuss@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by ozlabs.org (Postfix) with ESMTP id 4D41BDDE29
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 07:39:35 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so785343wag
	for <linuxppc-dev@ozlabs.org>; Fri, 09 Nov 2007 12:39:34 -0800 (PST)
Message-ID: <a340dd0e0711091239mdf1b772l1d5a8208f7def4f5@mail.gmail.com>
Date: Fri, 9 Nov 2007 15:39:34 -0500
From: "Mike Nuss" <nmx@fromtheshadows.net>
Sender: mikenuss@gmail.com
To: linuxppc-dev@ozlabs.org
Subject: Using PVR value after boot?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm writing a module for the Security/KASUMI function on the
PPC440EPx-S and PPC440GRx-S. This relies on checking the PVR value at
runtime, which is done early on in the boot process.  What would be
the correct way to check which CPU is present during module
initialization?

Thanks,
Mike
