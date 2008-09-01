Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 789C2DDF55
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Sep 2008 23:16:18 +1000 (EST)
Received: from LPSC0173W (lpsc0173w.in2p3.fr [134.158.40.173])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with SMTP id m81DGCWS027227
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Sep 2008 15:16:12 +0200
Message-ID: <02d301c90c34$e7c1f2d0$ad289e86@LPSC0173W>
From: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
To: <linuxppc-dev@ozlabs.org>
Subject: gdb woes
Date: Mon, 1 Sep 2008 15:16:05 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello all,
I have some trouble when trying to use gdb to debug a custom app.
That app crashes for no reason but always on the same spots (probably 
hardware related, it runs on homebrew ppc-based card).
I've used gdb in the past, but always as part of 'bigger' IDEs.

So I run "gdb myapp" locally on the card and I get the prompt. Then I "run" 
it and I get dumped back to bash, but a "ps" shows that the app is still 
running... Anybody has a clue to what I can do about this ? Is there 
something wrong with my gdb (it's compiled as part of buildroot, like the 
rest of the OS) ?
-- 
Guillaume Dargaud
http://www.gdargaud.net/ 
