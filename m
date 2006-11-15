Return-Path: <aldo.lab@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.191])
	by ozlabs.org (Postfix) with ESMTP id 3D2E867CD3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Nov 2006 01:54:53 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id n15so629111nfc
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Nov 2006 06:54:52 -0800 (PST)
Message-ID: <6e41d1460611150654j6e532ae1pbe378685539e257e@mail.gmail.com>
Date: Wed, 15 Nov 2006 15:54:51 +0100
From: "aldo lab" <aldo.lab@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Performance on PowerQuicc8280 linux based
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

I've a system Linux based on ppc8280 platform with unstable
performance from a compiling to another.
I've a board with 2 Ethernet interfaces and I inject traffic in one of
this and analyze the number of packets that I receive in the other
one.
I obtained 60000 pkt/s the first time, the second time i recompiling
the kernel just changing some died function that is not involved in
the flow of the packet.In that case I obtained 47000 pkt/s and it
seems that moving code position change the behaviour in term of cache
functionality.
Could someone help me to understand this strange situation

Regards
Aldo
