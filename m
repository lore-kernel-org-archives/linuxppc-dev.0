Return-Path: <netstv@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by ozlabs.org (Postfix) with ESMTP id 79F2367A5F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 May 2006 23:49:25 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id s49so322854pyc
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 May 2006 06:49:24 -0700 (PDT)
Message-ID: <b4b98b690605170649v4dcf748eoa1c9f9c5111252ed@mail.gmail.com>
Date: Wed, 17 May 2006 06:49:23 -0700
From: "Steve Iribarne (GMail)" <netstv@gmail.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Anyone seen this while debugging?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am using linux-2.4.32.

I am using a BDI2000 and I set break to SOFT

I am debugging a module and I use Denx scripts "add-module" so that I
know my module symbols are getting loaded in the right location.

Everytime I set a breakpoint in my module I get....

Program received signal SIGSTOP, Stopped (signal).
0x00000500 in ?? ()
The address moves around a bit but I always get this.  If I delete the
breakpoints it works fine.

Thanks in advance.

-stv
