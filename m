Message-ID: <3D3E4145.8030500@dslextreme.com>
Date: Tue, 23 Jul 2002 22:55:17 -0700
From: akuster <akuster@dslextreme.com>
Reply-To: akuster@dslextreme.com
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: [RFC/Patch] 4xx idle loop
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I was going though some old 4xx kernels I have and found an
implimentation of idle.c that had support for 4xx.  I believe the reason
it never made is out was the hacking we did to make it work.  So I
propose that we modify the kernel/Makefile to use ppc4xx_idel.o instead
of idle.o when 4xx is configured.  That way we have a clean
implimentation for 4xx idle functions and not touch the generic ppc idle
file.  The function names would not change.

Armin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
