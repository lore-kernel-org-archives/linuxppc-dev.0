Message-ID: <37E83203.D830C221@netx4.com>
Date: Tue, 21 Sep 1999 21:33:55 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Claude Robitaille <crobitaille@videotron.ca>
CC: Dan Malek <dan@penguin.netx4.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Compiling 2.3.18
References: <Pine.LNX.4.10.9909211959400.1386-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Claude Robitaille wrote:

> Is it ok to move the mpc8xx.h inclusion statement earlier in the
> irq.h file? Is there a reason for it to be late in the file?

I guess I need to ask what you are building and with what kernel.
The current file configuration seems to work fine with all of the
other boards.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
