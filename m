From: pierre.sutra@com2gether.net
Message-ID: <1085393236.40b1c9541927a@webmail.com2gether.net>
Date: Mon, 24 May 2004 06:07:16 -0400
To: linuxppc-dev@lists.linuxppc.org
Subject: conflict beteew SPI and SMC1
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm working on a SPI driver and i have a small but difficult to solve problem on
my MPC852T : a "conflict" between SMC1 and the SPI bus. In fact the data i send
on the spi bus are always preceded by a corrupt byte unless i do a printk() call
while i m sending.
I have made some hypothesis about this bug but i can't really  figure out what
really happen ( is it due to the shift register which is badly initialised or
the SDMA channel that did not do its job ... ? )
Any help would be greatly appreciated .

Pierre Sutra


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
