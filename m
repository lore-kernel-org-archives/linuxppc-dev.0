Return-Path: <ygeorgie@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id 413EADDDFF
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jan 2007 22:41:42 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so918785ugf
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jan 2007 03:41:40 -0800 (PST)
Message-ID: <7cc53cfa0701130341x2dfdc8f1s9cb70ffa741fafb6@mail.gmail.com>
Date: Sat, 13 Jan 2007 12:41:39 +0100
From: yuraxa <ygeorgie@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: ppc inline asm syntax
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, i'm writing some inline assembly for ppc.
Grepping linux src code for examples i found syntax that i can't
understand, but as i can see it's frequently used.  For example:

__asm__ __volatile__("lwz%U1%X1 %0,%1;\n"
                              "twi 0,%0,0;\n"
                              "isync" : "=r" (ret) : "m" (*addr));

Can you explain me please  howto interpret 'lwz%U1%X1'  format string
in the assembler template line? Some other of them are:

'stw%U0%X0'   etc...

I can't find any help on this topic on the web.

Thanks a'lot,
Yury.
