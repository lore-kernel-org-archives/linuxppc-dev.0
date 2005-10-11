Return-Path: <dick@softplc.com>
Received: from ylpvm53.prodigy.net (ylpvm53-ext.prodigy.net [207.115.57.84])
	by ozlabs.org (Postfix) with ESMTP id 16DF568543
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Oct 2005 20:42:22 +1000 (EST)
Received: from [192.100.100.10] ([67.64.64.34])
	by ylpvm53.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id
	j9BAatCG007852
	for <linuxppc-embedded@ozlabs.org>; Tue, 11 Oct 2005 06:36:55 -0400
Message-ID: <434B9648.5000608@softplc.com>
Date: Tue, 11 Oct 2005 05:39:04 -0500
From: Dick Hollenbeck <dick@softplc.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: What Can I do to port JVM on MPC?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

There is a JVM that is part of GCC called libgcj.  It differs from Sun's 
JVM in that is uses "ahead of time compilation" of the Java code all the 
way to machine code.  Whereas Sun's JVM runs on "java bytecode" and at 
runtime compiles this bytecode to machine code "just in time".

Unfortunately the build system for libgcj is abysmal and shameful, and 
the garbage collector will pause the process that runs it about 55 msecs 
every so often.  So aside from the build system and the GC, libgcj is 
excellent work.


I would start with libgcj.

    http://gcc.gnu.org/java/

It should be your path of best investment.


Been there, done that.


Regards,

Dick Hollenbeck

-- 
Please help fix the U.S. software industry before it is too late.
Contact your U.S. representatives with this information:
http://lpf.ai.mit.edu/Patents/industry-at-risk.html
http://www.groklaw.net/article.php?story=20041003041632172
