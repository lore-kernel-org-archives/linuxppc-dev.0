Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A409067B1F
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Mar 2006 20:10:10 +1100 (EST)
Date: Mon, 27 Mar 2006 01:10:08 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: linuxppc-dev@ozlabs.org
Subject: "[PATCH] tvec_bases too large for per-cpu data" breaks 440 user-space
Message-ID: <20060327091008.GA19918@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi!

latest kernel.org's 2.6 fails to boot on 440GX eval board (init 
hangs).

git-bisect points to this generic change:

a4a6198b80cf82eb8160603c98da218d1bd5e104
[PATCH] tvec_bases too large for per-cpu data

I cannot tell now why this is causing problems, benh thinks that 
"changes cpu/per-cpu" might be responsible.

It's likely that other PPC subarchs are affected as well.

-- 
Eugene
