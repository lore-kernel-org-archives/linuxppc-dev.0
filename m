Date: Fri, 21 Jun 2002 16:59:03 -0300
From: Ricardo Scop <scop@vanet.com.br>
Reply-To: Ricardo Scop <scop@vanet.com.br>
Message-ID: <19707.020621@vanet.com.br>
To: Tim Lai <laitingwai@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re[2]: Can I run linux without a file system?
In-reply-To: <20020621194234.37274.qmail@web21103.mail.yahoo.com>
References: <20020621194234.37274.qmail@web21103.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tim,

See bellow...

[]'s, Scop                            mailto:scop@vanet.com.br

------------------------------------------------------------------
It might look like I'm doing nothing, but at the cellular level I'm
really quite busy.

Friday, June 21, 2002, 4:42:34 PM, you wrote:


TL> I am interested in both input/output operation
TL> on the console. If I just set CONFIG_SERIAL_CONSOLE,
TL> will I be able read input from the console?
TL> The main application will be started from init(),
TL> and the application will need to read and write
TL> to the console. Are there are method to communicate
TL> to the serial port other than open("/dev/ttyS0")?
Not AFAIK. The VFS (Virtual File System) is at the very heart of Linux
and _is_ the abstraction used to deal with I/O devices. You don't need
to try avoiding it. A simple initrd will do the job and can be as
light as you make it.

>>
>> You don't need a filesystem to get output on the
>> serial console
>> you just need to enable the console with
>> CONFIG_SERIAL_CONSOLE=y
>> in your kernel configuration (atleast for mpc860
>> that all)
>> but you will have a hard time producing much more
>> than a blinking
>> cursor if you boot a Linux kernel and have no
>> application that
>> it then can run on the root-filesystem - what would
>> be the point
>> of such a setup - 1MB kernel code for a blinking
>> cursor on a
>> serial port seems expensive.
you get the network protocol stacks, too...

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
