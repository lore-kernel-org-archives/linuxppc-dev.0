Message-ID: <3E6384F6.9090701@mvista.com>
Date: Mon, 03 Mar 2003 10:38:14 -0600
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Stephan Linke <Stephan.Linke@epygi.de>
Cc: Bret Indrelee <Bret.Indrelee@qlogic.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: "printk" does not print
References: <FCEAKDJJAPHPLJFINDAJCEEBCOAA.Stephan.Linke@epygi.de>
In-Reply-To: <FCEAKDJJAPHPLJFINDAJCEEBCOAA.Stephan.Linke@epygi.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stephan Linke wrote:
> Hi,
>
> if your startup skript changes the console log level in /proc/sys/kernel/printk maybe not all messages are displayed on console. But
> you can still look into /var/log/messages.

...assuming you have klogd/syslogd installed and running...

--Mark

> Regards, Stephan
>
>
>>-----Original Message-----
>>From: owner-linuxppc-embedded@lists.linuxppc.org
>>[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Bret
>>Indrelee
>>Sent: Montag, 3. Marz 2003 15:46
>>To: Ing.Gianfranco Morandi
>>Cc: LinuxPPC
>>Subject: Re: "printk" does not print
>>
>>
>>
>>On Mon, 3 Mar 2003, Ing.Gianfranco Morandi wrote:
>>
>>>Hi to all,
>>>
>>>I'm trying to trace the execution path of a custom ISDN driver, and I have
>>>used some printk() instructions to give some messages out.
>>>
>>>Now, everything is going well, but when I try to open the ttyI0 device (or
>>>ttyIx it is the same) the printk() that I have placed into the file
>>>isdn_tty.c does not print any messages. I am sure that such procedure has
>>>been executed because I have placed a breakpoint on the "isdn_tty_open()"
>>>and the program stopped.
>>>
>>>Anybody has an idea what happens?
>>
>>You probably neglected to set a KERN_ level.
>>
>>See if they are in your dmesg or messages file, you might be sending them
>>to syslog but not the screen.
>>
>>-Bret
>>
>>--
>>Bret Indrelee                 QLogic Corporation
>>Bret.Indrelee@qlogic.com      6321 Bury Drive, St 13, Eden Prairie, MN 55346


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
