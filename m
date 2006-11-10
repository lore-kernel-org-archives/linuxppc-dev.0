Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw2.sony.co.jp (MGW2.Sony.CO.JP [137.153.0.14])
	by ozlabs.org (Postfix) with ESMTP id 315CB67CB9
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 07:00:22 +1100 (EST)
Received: from mail3.sony.co.jp (localhost [127.0.0.1])
	by mail3.sony.co.jp (R8/Sony) with ESMTP id kAAK0KbC013402
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 05:00:20 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail3.sony.co.jp (R8/Sony) with SMTP id kAAK0Kl5013392
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 05:00:20 +0900 (JST)
Message-ID: <4554DA4D.9010909@am.sony.com>
Date: Fri, 10 Nov 2006 12:00:13 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/16] patches for 2.6.20
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

This is the set of patches I have queued for 2.6.20.  Patches 1-6 have
already been posted, but I did some re-work on a few to bring them up
to the latest powerpc.git.  Patches 7-16 are new and add the core
platform support for the PS3 game console.

For the convenience of anyone interested, I have put this patchset, plus
a few other drivers I am working on with some info here:

  http://67.117.136.164/pub/cell/

-Geoff
