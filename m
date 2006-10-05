Return-Path: <wei.li4@elf.mcgill.ca>
Received: from drizzle.cc.mcgill.ca (drizzle.cc.mcgill.ca [132.206.27.48])
	by ozlabs.org (Postfix) with ESMTP id 3F15367DC7
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Oct 2006 23:29:52 +1000 (EST)
Received: from mailscan3.cc.mcgill.ca (mailscan3.CC.McGill.CA [132.216.77.250])
	by drizzle.cc.mcgill.ca (8.12.11/8.12.3) with ESMTP id k95DTo7K006889
	for <linuxppc-embedded@ozlabs.org>; Thu, 5 Oct 2006 09:29:50 -0400
Received: from wgrappe1.cc.mcgill.ca (wgrappe1.CC.McGill.CA [132.216.46.250])
	by mailscan3.cc.mcgill.ca (8.13.6/8.13.0) with ESMTP id
	k95DTk9L002735
	for <linuxppc-embedded@ozlabs.org>; Thu, 5 Oct 2006 09:29:46 -0400 (EDT)
Received: from wgrappe1.cc.mcgill.ca (localhost.localdomain [127.0.0.1])
	by wgrappe1.cc.mcgill.ca (8.13.7/8.13.4) with ESMTP id k95DTkKA013368
	for <linuxppc-embedded@ozlabs.org>; Thu, 5 Oct 2006 09:29:46 -0400
Received: (from apache@localhost)
	by wgrappe1.cc.mcgill.ca (8.13.7/8.13.7/Submit) id k95DTk6C013365
	for linuxppc-embedded@ozlabs.org; Thu, 5 Oct 2006 09:29:46 -0400
Message-ID: <20061005092946.2004afu1wwc4kkcg@webmail.mcgill.ca>
Date: Thu, 05 Oct 2006 09:29:46 -0400
From: wei.li4@elf.mcgill.ca
To: linuxppc-embedded@ozlabs.org
Subject: Compiler Question
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

It seems that there is a rule that Compiler or Linker assigns r3, r4 
... to the arguments of C function when it is called, and r1 is the 
address of Stack Pointer, and how is for r0 and r2? where can I find 
these rules? Thanks.

Wei
