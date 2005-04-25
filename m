Return-Path: <achim.machura@berghof.com>
Received: from pegasus.berghof.com (unknown [145.253.135.72])
	by ozlabs.org (Postfix) with ESMTP id 5909667B28
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Apr 2005 17:07:14 +1000 (EST)
From: "Achim Machura" <achim.machura@berghof.com>
To: "'Mark Chambers'" <markc@mail.com>
Date: Mon, 25 Apr 2005 08:51:20 +0200
Message-ID: <000501c54963$306766c0$34f1ff0a@beint.local>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <002101c54774$83c85590$0301a8c0@chuck2>
Cc: "Linuxppc-Embedded \(E-Mail\)" <linuxppc-embedded@ozlabs.org>
Subject: AW: pthread debugging problem
Reply-To: achim.machura@berghof.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Mark,

-----Ursprüngliche Nachricht-----
Von: linuxppc-embedded-bounces@ozlabs.org
[mailto:linuxppc-embedded-bounces@ozlabs.org]Im Auftrag von Mark Chambers
Gesendet: Freitag, 22. April 2005 21:50
An: linuxppc-embedded@ozlabs.org
Betreff: pthread debugging problem


<I am debugging a simple program with several threads, using pthreads.
<printf's tell me that the threading is working, but I am unable to debug
<the program with gdb (gdbserver on the target).  I get spurious
<'Program received signal SIG32, Real-time even 32' messages.
<I'm using a stock ELDK tree via NFS boot.  I couldn't tell you the ELDK
<version but I've listed some of the components below.

Sometimes we have the same problems.
We have solved it by telling gdb the path of the libs using,
set SOLIB_ABSOLUTE_PREFIX.
Also there is a problem if you use different versions of dynamic libraries
for the progamm and the gdb.

achim
