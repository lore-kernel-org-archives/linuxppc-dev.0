Date: Mon, 8 Dec 2003 21:02:37 -0300
From: Ricardo Scop <scop@digitel.com.br>
Reply-To: Ricardo Scop <scop@digitel.com.br>
Message-ID: <6876.031208@digitel.com.br>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re[2]: 8270 performance
In-reply-To: <AB5AF73EAF23304EA1B932174137CED7030447@m5tmail.m5t.com>
References: <AB5AF73EAF23304EA1B932174137CED7030447@m5tmail.m5t.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Jean-Denis,

Monday, December 08, 2003, 6:11:30 PM, you wrote:


JDB> Ricardo,
JDB> Jaap-Jan,

>> > I would expect the bogomips number
>> > to be somewhere near the core clock
>> > (like 8xx).
>>
>> Well, I think the numbers are pretty fair, assuming that the
>> bogomips number
>> reflect a certain amount of external memory accesses at 66
>> MHz external bus
>> clock.

JDB> It has more to do with pipelining!
JDB> Hopefully, there ain't any memory access during calibration...
JDB> (except, of course, when the instruction cache is disabled!)

JDB> I didn't look at the documentation, but the execution of a branch probably occurs later in the pipeline of a 8260 than for the 860. It probably looses one more cycle. The calibration relies on
JDB> the execution speed of function __delay (arch/ppc/kernel/misc.S), which loops on a branch instruction 'bdnz'.

Ooops, I should learn to read the source code before making any
assumptions. Sorry for the mistake, and many thanks for the lesson!

-Scop.

JDB> Regards,
JDB> --------------------------------------------
JDB>  Jean-Denis Boyer, Eng.
JDB>  M5T Centre d'Excellence en Télécoms Inc.
JDB>  4283 Garlock Street
JDB>  Sherbrooke (Québec)
JDB>  J1L 2C8  CANADA
JDB>  (819)829-3972 x241
JDB> --------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
