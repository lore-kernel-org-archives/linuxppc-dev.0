Date: Fri, 21 Jun 2002 16:46:00 -0300
From: Ricardo Scop <scop@vanet.com.br>
Reply-To: Ricardo Scop <scop@vanet.com.br>
Message-ID: <15698.020621@vanet.com.br>
To: Tim Lai <laitingwai@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re[2]: Can I run Linux without a file system?
In-reply-To: <20020621193517.35031.qmail@web21110.mail.yahoo.com>
References: <20020621193517.35031.qmail@web21110.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tim,

Maybe initrd and linuxrc is enough for your system. Read the file
initrd.txt in the Linux source tree Documentation sub-directory.

[]'s, Scop                            mailto:scop@vanet.com.br

------------------------------------------------------------------
It might look like I'm doing nothing, but at the cellular level I'm
really quite busy.

Friday, June 21, 2002, 4:35:17 PM, you wrote:


TL> Thanks, Jason.
TL> I am new to linux kernel. I'll have the main
TL> application run from init(), so I wasn't planning
TL> to have a file system.

>> Yes. You will always have SOME kind of filesystem.
>> But this begs another
>> question. How much do you know about Linux, and what
>> are you really asking?

TL> If /proc and /dev is not really on any disk, what do
TL> I have to do to init or create /dev? Do I need ramdisk
TL> as a minumum requirement for linux?
TL> My main goal right now is to get the serial port
TL> to work, so I can do some debugging with the dumb
TL> terminal. After I do tty_register() in the serial
TL> driver, does linux assign /dev/ttyS to this device?

>> The /proc filesystem is not really on any disk, just
>> like /dev (I think)
>> isn't on any disk, though they look like to us users
>> that they are
>> filesystems.
>>

TL> Can you give me pointers on which file to read?

>>
>> Does this help?
>>

TL> Yes. Thank you very much. :)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
