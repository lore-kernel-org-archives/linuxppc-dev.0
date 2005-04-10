Return-Path: <yeokiwi@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.198])
	by ozlabs.org (Postfix) with ESMTP id 7722B67A2E
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 10 Apr 2005 14:57:57 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id g11so1911323rne
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 09 Apr 2005 21:57:55 -0700 (PDT)
Message-ID: <af025844050409215122eff23@mail.gmail.com>
Date: Sun, 10 Apr 2005 12:51:15 +0800
From: Yeo Keewee <yeokiwi@gmail.com>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <20050410020004.967A967B3E@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20050410020004.967A967B3E@ozlabs.org>
Subject: Problem with customized MPC5200 board(copy from lite5200 design)
Reply-To: Yeo Keewee <yeokiwi@gmail.com>
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

Our hardware group had designed a mpc5200 board using the same design
as lite5200.
Currently, we are using bdi2000(icecube config) to attempt to access
the internal registers. By using the same procedure on lite5200, we
can access the registers but we always could not do it on our board.

Besides a hardware design flaw, is there any other init procedures
that are required to use bdi2000 on our custom board?

Did anyone face this kind of problem?

rgds
Yeo Kee Wee
