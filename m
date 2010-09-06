Return-Path: <tmarri@apm.com>
Received: from exprod5og114.obsmtp.com (exprod5og114.obsmtp.com [64.18.0.28])
	by ozlabs.org (Postfix) with SMTP id EABC4B70EE
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  6 Sep 2010 15:19:58 +1000 (EST)
Received: by mail-qw0-f45.google.com with SMTP id 5so3673558qwh.4
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 05 Sep 2010 22:19:56 -0700 (PDT)
From: Tirumala Marri <tmarri@apm.com>
References: <1283464653-18492-1-git-send-email-tmarri@apm.com>
	<20100903020851.GC29732@hansolo.jdub.homelinux.org>
	<197d4509c0b1206ce2d686c03701a6b4@mail.gmail.com>
	<20100905222340.GC2150@lixom.net>
In-Reply-To: <20100905222340.GC2150@lixom.net>
MIME-Version: 1.0
Date: Sun, 5 Sep 2010 22:19:53 -0700
Message-ID: <01bb9090932e6984c887273078fd586f@mail.gmail.com>
Subject: RE: [PATCH] APM821xx: Add support for new SoC APM821xx
To: Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
> Then the device tree identifier, and the cpu setup functions, etc,
> should indicate
> 464, not APM821xx.
This is new SoC based on 464 cpu core. All the previous SoC device tree
CPU portion uses SoC name.

>
> Also, why add yet another defconfig? Isn't the eval board similar to
> many others and can be supported with just a tweak of some existing
> common defconfig instead?
>
Every new board needs new defconfig. And it is not same as others. It has
Different features from other.
