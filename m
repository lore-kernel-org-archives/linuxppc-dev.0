Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id 2731EDDF4D
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2008 05:38:06 +1000 (EST)
Received: from [192.168.1.37] (node20.74.251.72.1dial.com [72.251.74.20])
	(authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id m54JaMq9078411
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Jun 2008 12:37:58 -0700 (PDT)
Message-ID: <4846EEAE.3000908@hypersurf.com>
Date: Wed, 04 Jun 2008 12:36:14 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: inline assembly
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

	When doing inline assembly, is there a way to get the compiler to 
assign "extra" (one not specified for inputs and outputs) registers? In 
the following:

                 __asm__ __volatile__ (
                         "addi 5,%1,-1\n"
                         "andc 5,%1,5\n"
                         "cntlzw 5,5\n"
                         "subfic %0,5,31":
                         "=r"(j):
                         "r"(i)
                 );

Can I get the compiler to choose a register for r5?

kevin
