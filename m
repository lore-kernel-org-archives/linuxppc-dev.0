Message-ID: <39D7AD4E.2E117C8E@mvista.com>
Date: Sun, 01 Oct 2000 17:31:58 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: jari.nguyen@smartstors.com
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Memory map?
References: <39D59806.9AE0F189@serialsystem.com.sg>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jari wrote:

> After booting kernel, I want to access the physical address in rom ,
> for example:
> my rom begins at 0xFE00 0000, and I want to read 1 byte at this address.

When exactly do you want to do this, is it in the kernel or by an
application, and what kind of system are you using?  There are many
ways to do this....


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
