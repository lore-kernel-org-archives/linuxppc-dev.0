Return-Path: <rbrito@ime.usp.br>
Received: from smtp.gru.flash.tv.br (smtp.flash.net.br [201.46.240.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 26896DDF2A
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 13:55:27 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by smtp.gru.flash.tv.br (Postfix) with ESMTP id 816311C7E83
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 00:55:19 -0300 (BRT)
Received: from smtp.gru.flash.tv.br ([127.0.0.1])
	by localhost (smtp.gru.flash.tv.br [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP id apa9ImqsrGDp for <linuxppc-dev@ozlabs.org>;
	Thu, 11 Sep 2008 00:55:13 -0300 (BRT)
Received: from chagas.nectar.ath.cx (189-39-150-199.gru.flash.tv.br
	[189.39.150.199])
	by smtp.gru.flash.tv.br (Postfix) with ESMTPA id 927991C7327
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 00:55:13 -0300 (BRT)
Date: Thu, 11 Sep 2008 00:55:14 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Paul Mackerras <paulus@samba.org>
Subject: Getting Debian to release the PowerPC port
Message-ID: <20080911035514.GE8077@ime.usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, 497605@bugs.debian.org,
	debian-powerpc@lists.debian.org, debian-release@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Paul,

I would like to ask you a few things:

* which is the official dtc git repository?
  I ask it here because dtc.ozlabs.org doesn't seem to work, but this is
  what is linked to from the page <http://ozlabs.org/> and the
  device-tree-compiler package on Debian has an outdated page (it
  seems). I already filed a bugreport to that package
  (http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=497605).

* where can I find the people responsible for glibc and gcc/g++ so that
  I can fill in the empty fields at
  <http://wiki.debian.org/powerpcLennyReleaseRecertification>, so that
  powerpc does not become "at risk" of not being released? Is the
  powerpc port cared by some team in special or is it just a "unified"
  upstream?


Thanks in advance, Rogério Brito.

-- 
Rogério Brito : rbrito@{mackenzie,ime.usp}.br : GPG key 1024D/7C2CAEB8
http://www.ime.usp.br/~rbrito : http://meusite.mackenzie.com.br/rbrito
Projects: algorithms.berlios.de : lame.sf.net : vrms.alioth.debian.org
