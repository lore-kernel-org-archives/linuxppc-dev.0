Message-ID: <3A7F09AD.1EE45051@mvista.com>
Date: Mon, 05 Feb 2001 15:14:37 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Lucinda Schafer <lucsch@adaptivemicro.com>
CC: "'Christopher Huffine'" <huffine@wopr.nrl.navy.mil>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Serial port two on an 823 based system (BSE-IPEngine) (Additional
 Thoughts)
References: <A109131318C4D1119AC20060088DECE34B8F32@mail.adaptivemicro.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Lucinda Schafer wrote:
>
> We started with a BSE board and moved on to our own design. The kernel
> version we use is 2.2.13.


This is a really old and effectively unsupported kernel.  The SMC2
changes for 823/850 have been in later kernel sources, along with
important microcode relocation patches if you want to use USB or
SCC3 (on 823e or 850) for Ethernet.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
