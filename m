Return-Path: <sauros@gmail.com>
Received: from wx-out-0102.google.com (wx-out-0102.google.com [66.249.82.198])
	by ozlabs.org (Postfix) with ESMTP id E681E67B14
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 May 2006 07:22:03 +1000 (EST)
Received: by wx-out-0102.google.com with SMTP id h29so202122wxd
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 03 May 2006 14:22:02 -0700 (PDT)
Message-ID: <c359a7c00605031415o545d761cha3a3498c9454f3df@mail.gmail.com>
Date: Wed, 3 May 2006 18:15:22 -0300
From: "Sauro Salomoni" <sauros@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Where to look for CRAMFS
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

Greetings.

I have an embedded board using i.MX21.

What I want to know is: how do I tell the kernel where my CRAMFS root
file system is?
I mean, I put it in a specific memory address, but how does the kernel
know where it is?!

What happens here is that the kernel looks in some address and don't
find the Magic Number CRAMFS stores in its own start address. I have a
"bad magic number" msg because my root fs is somewhere else.
Can anyone help me, plz?

Thanks in advance.


Sauro
Engineer
Z Tec
www.ztec.com.br
+55 61 3322-2544
