Return-Path: <pengxihan@gmail.com>
Received: from mail-pw0-f50.google.com (mail-pw0-f50.google.com
	[209.85.160.50]) by ozlabs.org (Postfix) with ESMTP id B9039B7BA1
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Oct 2009 14:43:35 +1100 (EST)
Received: by pwi4 with SMTP id 4so3541343pwi.9
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Oct 2009 20:43:34 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 27 Oct 2009 11:43:34 +0800
Message-ID: <389deec70910262043v34bcd7edy6f00241d126b1816@mail.gmail.com>
Subject: Is there a patch for MPC8548 XOR?
From: hank peng <pengxihan@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I want to use its' XOR engine to compute raid5 parity, but I can't
find this function in 2.6.30 downloaded from kernel.org, someone know
if there is a patch?

-- 
The simplest is not all best but the best is surely the simplest!
