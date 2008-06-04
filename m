Return-Path: <jacmet@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.188])
	by ozlabs.org (Postfix) with ESMTP id 2F8F7DDED9
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jun 2008 07:31:45 +1000 (EST)
Received: by fk-out-0910.google.com with SMTP id e30so323822fke.9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 04 Jun 2008 14:31:43 -0700 (PDT)
To: John Linn <John.Linn@xilinx.com>
Subject: Re: linux 2.6 hangs at __delay function on Viretx 4 board
References: <17222725.post@talk.nabble.com>
	<20080514150139.E258D8D006F@mail70-va3.bigfish.com>
	<17276753.post@talk.nabble.com>
	<20080516162807.2132E181804D@mail89-sin.bigfish.com>
	<17454696.post@talk.nabble.com> <17482754.post@talk.nabble.com>
	<20080528140800 <20080604212233.37F44130004F@mail123-sin.bigfish.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 04 Jun 2008 23:31:40 +0200
In-Reply-To: <20080604212233.37F44130004F@mail123-sin.bigfish.com> (John
	Linn's message of "Wed\, 4 Jun 2008 15\:22\:31 -0600")
Message-ID: <87k5h4opj7.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: swamydp <swamydp@gmail.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "John" == John Linn <John.Linn@xilinx.com> writes:

 John> Hi Peter,
 John> Yes you need to enable UARTLITE as the console in the kernel
 John> configuration.

Yeah, I know - I wrote the driver after all ;)

 John> You have the command line syntax, ttyUL0, correct.

 John> They have now changed the UART 16550 to be a free core in the EDK, not
 John> sure which version of the EDK that happened.

Ok.

-- 
Bye, Peter Korsgaard
