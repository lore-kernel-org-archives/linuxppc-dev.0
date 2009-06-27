Return-Path: <kernelmailz@googlemail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 315C0B7043
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 28 Jun 2009 05:47:01 +1000 (EST)
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.157])
	by ozlabs.org (Postfix) with ESMTP id 5DFFEDDD04
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Jun 2009 05:46:58 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so884708fga.16
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jun 2009 12:46:56 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 28 Jun 2009 01:16:56 +0530
Message-ID: <abe8a1fd0906271246q920124ard61422d9577e2d09@mail.gmail.com>
Subject: Inline Assembly queries
From: kernel mailz <kernelmailz@googlemail.com>
To: gcc-help@gcc.gnu.org, gcc-help-help@gcc.gnu.org, linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello All the gurus,

I've been fiddling my luck with gcc 4.3.2 inline assembly on powerpc
There are a few queries

1. asm volatile or simply asm produce the same assembly code.
Tried with a few examples but didnt find any difference by adding
volatile with asm

2. Use of "memory" and clobbered registers.

"memory" -
a. announce to the compiler that the memory has been modified
b. this instruction writes to some memory (other than a listed output)
and GCC shouldn=92t cache memory values in registers across this asm.

I tried with stw and stwcx instruction, adding "memory" has no effect.

Is there any example scenerio where gcc would generate different
assembly by adding / removing "memory" ?


-TZ
