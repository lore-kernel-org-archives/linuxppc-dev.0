Message-ID: <384FF2EB.DB671513@netx4.com>
Date: Thu, 09 Dec 1999 13:20:27 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Ralf HECKHAUSEN <RHeckhau@frequentis.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kernel configuration problem
References: <s84fbf1f.064@mail.frequentis.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ralf HECKHAUSEN wrote:


> When I select the frame buffer option, I get an unresolved reference error (video_setup) in main.o. The only thing to get arround this is to chose the Virtual Terminal option. But then I get an unresolved reference error (request_irq) in pc_keyb.o. Im am using the kernel 2.2.5. Isn't there a way just to use the frambuffer without console and keyboard?

No....You have to include lots of this stuff, and then go into
the initialization files and make sure the initialization functions
for things like the keyboard are not called.  Not very embedded
friendly and something that needs attention.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
