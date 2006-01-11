Return-Path: <wd@denx.de>
To: batsayan.das@tcs.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 11 Jan 2006 13:03:02 +0530."
	<OFDC66830E.1EDE14C4-ON652570F3.00265CDF-652570F3.00297A66@tcs.com>
Date: Wed, 11 Jan 2006 21:34:34 +0100
Sender: wd@denx.de
Message-Id: <20060111203434.1D928352B1E@atlas.denx.de>
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: Ethernet not initialized: Help req 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <OFDC66830E.1EDE14C4-ON652570F3.00265CDF-652570F3.00297A66@tcs.com> you wrote:
> 
> In our MPC8260 based customs board the CLK9 is for transmit and CLK10 is 
> for receive. The ELDK tree uses  CLK12 is receive, CLK11 is transmit and 

This is not correct. The ELDK does not do this. The  ELDK  is  not  a
Linux source tree.

Also, this setting is hardware dependent and differs  from  board  to
board.

> We got CLK9  and CLK10 from U-Boot tree and set those varables, but 
> ethernet does not work. 

Then   probably   other   changes   /   initializations   (port   pin
configurations) are needed as well.

> My question is what value shall I use for CLK9 and CLK10? 

This idepends on your hardware. Study the schematics.

> What else setting we need to change to make Ethernet work?

Compare U-Boot code and other board definitions.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A secure program has to be robust: it  must  be  able  to  deal  with
conditions  that "can't happen", whether user input, program error or
library/etc. This is basic damage  control.  Buffer  overflow  errors
have nothing to do with security, but everything with stupidity.
                 -- Wietse Venema in <5cnqm3$8r9@spike.porcupine.org>
