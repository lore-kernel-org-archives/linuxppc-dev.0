Message-ID: <3E8C766D.70705@pacbell.net>
Date: Thu, 03 Apr 2003 09:59:09 -0800
From: David Brownell <david-b@pacbell.net>
MIME-Version: 1.0
To: "Kholodnyi, Andrei" <Andrei.Kholodnyi@fci.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>,
	"'linux-usb-devel@lists.sourceforge.net'" <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] USB host and gadget drivers for MPC850
References: <9CFB9DA5261CD611A29B00508B7890484A10D6@ex-deu-munich02.force.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kholodnyi, Andrei wrote:
> Hi All,
>
> We plan to use two MPC850 with USB point-to-point communication link between
> them,
> where one MPC850 will support host interface another one gadget interface.
> Does USB gadget driver exist for MPC850?

There's no controller driver using the new gadget framework at

     http://kernel.bkbits.net/~david-b/

I'd merge patches for mpc850 support, if anyone offered ... :)

Given that hardware support, you should be able to use those
two gadget drivers with only minor tweaks.  And maybe that
CDC Ethernet gadget driver would solve part of your problem.

- Dave



> As USB host driver we'll use Brad Parker's USB hci driver.
>
> Best regards,
> Andrei.
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
