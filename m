Message-Id: <3.0.6.32.19990202101943.007e4d30@hsins.uia.ac.be>
Date: Tue, 02 Feb 1999 10:19:43 +0100
To: Gabriel Paubert <paubert@iram.es>
From: David De Ridder <david.de.ridder@bitsmart.com>
Subject: Re: LinuxPPC on MVME 2306 board
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.HPP.3.96.990201140400.16636D-100000@gra-ux1.iram.es>
References: <3.0.6.32.19990201104813.00804be0@hsins.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 14:13 1-2-99 +0100, Gabriel Paubert wrote:

>> As I understand from some messages in this list, several people have
>> been able to run LinuxPPC on such boards.
>
>At least simliar ones, I don't remember exactly what the 230x has. But as
>long as it has a DEC21x4x Ethernet, there should not be any problem...

 It has a DEC21140 Ethernet controller (with RJ-45 plug) and a serial
 interface (PC16550 UART).

>> 2) Since we don't have a spare developer PPC machine, is it possible
>>    to crosscompile the LinuxPPC kernel from the standard Linux sources
>>    on an Intel based machine ? I tried it and had problems with an
>>    unfound 'semaphore.h' file.
>> 
>
>Yes, you'll need a rather recent egcs version. 

 The egcs on that machine came with a Slackware 3.6 (Octobre 1998?). It
 should be recent. And how will a new egcs prevent the unfound-include-file-
 problem from happening ?

>I have put an untested zImage on my ftp server (I want to test it soon):
>
>ftp://vcorr1.iram.es/pub/linux-2.2/zImage.nfsroot-2.2.0

 Thank you. BTW, is is possible to use 'rdev' on a cross-compiled
 kernel image ? I mean : can I set the root device for a LinuxPPC with
 a PC's rdev ?
 
 Thanks,

+-----------------------------------------------------------------+
  David 'Septimus' De Ridder       <david.de.ridder@bitsmart.com> 

"If sharks were man-hunters, surfing would never have been invented."
 - ITV 'Shark Attack' Special

+-----------------------------------------------------------------+
  


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
