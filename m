Return-Path: <johnny.hacking@gmail.com>
Received: from mail-px0-f177.google.com (mail-px0-f177.google.com
	[209.85.216.177]) by ozlabs.org (Postfix) with ESMTP id 3A38AB7B70
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 23 Sep 2009 13:55:38 +1000 (EST)
Received: by pxi7 with SMTP id 7so289716pxi.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Sep 2009 20:55:36 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 23 Sep 2009 11:55:36 +0800
Message-ID: <cb9ecdfa0909222055x1d691698sb516b5b8f5f81d@mail.gmail.com>
Subject: GPIO driver for MPC8313.
From: Johnny Hung <johnny.hacking@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, linux-embedded@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All:
=A0 =A0Is there a alreday written GPIO dirver or example for
MPC8313/similar ppc platform. It looks like many people need GPIO
dirver to control LED, etc... I think is it possible to write a
general gpio driver for all ppc platform and only need to modify gpio
iomap information of dtb file. Please give me a advice. Thanks in
advanced.

BRs, H. Johnny
