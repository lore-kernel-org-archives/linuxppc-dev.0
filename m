Message-ID: <3CEC627C.9000709@embeddededge.com>
Date: Wed, 22 May 2002 23:31:08 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: dnevil@snmc.com
Cc: linuxppc-embedded@lists.linuxppc.org, sjl@dent.vctlabs.com
Subject: Re: No Input from SMC1 on MPC860T - Resolved
References: <1541.206.104.177.96.1022091123.squirrel@nevil.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Daris A Nevil wrote:

>>The key was to not enable the FRZ signal when setting up the timerbase;
>>apparently I was getting a spurious freeze signal which was turning off
>>my timer interrupts partway through.

If you are getting a "spurious freeze" signal, wouldn't you consider
something amiss with your hardware design or SIU/debug configuration?
If the timers are responding to a freeze condition, so is the rest
of the processor core, which isn't a good thing unless you are actively
debugging.

Please do not apply this patch, but rather find the cause of the real
problem since I prefer to freeze the timers while debugging.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
