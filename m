Message-ID: <3BEB0FDE.9080107@embeddededge.com>
Date: Thu, 08 Nov 2001 18:06:06 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org,
	linuxppc-commit@source.mvista.com
Subject: Re: Incoming to hostme.bitkeeper.com:/ua/repos/p/ppc/linuxppc_2_4_devel
References: <20011108193006.26A0010028@hostme.bitkeeper.com> <20011108123809.C1700@cpe-24-221-152-185.az.sprintbbd.net> <3BEAFBCE.5000702@embeddededge.com> <20011108144704.B2271@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:


> Yes, but then you end up....

Not what I had in mind :-).

For example, in include/asm-ppc/mpc8xx.h:
	#define piggy_serial_init()	mpc_serial_init(bp)

...and in include/asm-ppc/ibm4xx.h
	#define piggy_serial_init()	serial_init(0)

...and in misc-embedded.c change you list of #ifdefs to be:
	piggy_serial_init();

If the individual boards need some different initialization, just
move the macro to a lower level include file.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
