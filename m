Return-Path: <krom@dgt-lab.com.pl>
Received: from dgt-lab.com.pl (unknown [195.117.141.6])
	by ozlabs.org (Postfix) with ESMTP id B9C0167A64
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Feb 2005 01:13:17 +1100 (EST)
Received: from [192.168.7.66] (proxy.dgt.com.pl [195.117.141.11])
	by dgt-lab.com.pl (Postfix) with ESMTP id 0AB342E870
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Feb 2005 15:13:11 +0100 (CET)
Message-ID: <4219EC67.1070602@dgt-lab.com.pl>
Date: Mon, 21 Feb 2005 15:12:56 +0100
From: Wojciech Kromer <krom@dgt-lab.com.pl>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: any hints using gcc 3.4.3 for 2.4.25 kernel?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

a)first i have:
- 2.4.25 kernel (from denx cvs)
- eldk with 2.95.4 compiler
this one set works fine :)

b)then, i've tried  to same sources with:
gcc-3.4.3 , self build from uClibc buildroot
new hernel hangs just after decompressing :(

any tricks?
