Message-Id: <v03130305b2d231353f9c@[192.168.0.1]>
In-Reply-To: <199901250114.SAA21010@shell.rmi.net>
References: <v03130301b2d040f84476@[192.168.0.1]> from "Samuel Rydh" at
 Jan 24, 99 04:48:41 am
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 25 Jan 1999 16:12:52 +0100
To: Tom Harrington <tph@rmi.net>
From: Samuel Rydh <samuel@ibrium.se>
Subject: Re: mac-on-linux project status
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> 4. Status of Hardware Emulation
>>
>> The processor emulation is fairly complete, with some  exceptions:
>>
>>   - floating point instructions
>>   - 603 support
>>   - HIDx registers
>>
>> Some things in the MMU code needs to be fixed and tuned,  but the MMU
>> emulaton is in principle complete.
>
>Just out of curiosity, have you considered using PSIM?  It sounds like
>it's a pretty complete PowerPC emulator.
><ftp://cambridge.cygnus.com/pub/psim/index.html>.
>
>

The idea is to run things natively on the processor. For instance, all
user level instructions are run at full speed. The only thing needed
to be emulated are the priviliged instructions. Since priviliged
instructions only are used by the operating system for such things
as interrupt control, mac-on-linux runs at in principle 100% speed.

The "emulation" of the MMU works in a similar manner. Mac-on-linux
acts like a glue between the physical MMU and the MMU the mac-process
expects there to be. When a segment register is loaded for instance,
mac-on-linux simply translates the context number.

/Samuel



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
