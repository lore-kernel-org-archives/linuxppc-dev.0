Message-ID: <3DEE7FA8.7000908@bluewin.ch>
Date: Wed, 04 Dec 2002 23:20:24 +0100
From: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
MIME-Version: 1.0
To: Brian Waite <waite@skycomputers.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: NFS root woes: No init found
References: <200212041635.31861.waite@skycomputers.com> <3DEE781C.5070208@embeddededge.com> <200212041711.04032.waite@skycomputers.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

if you get to the bash prompt you could try to start the init program
manually. This should result in more useful error messages.

Hope it helps,

Wolfgang.


On 12/04/2002 11:11 PM Brian Waite wrote:
> I did this. I tried to start a staticly linked ash shell to no avail. No libs
> are better than any libs :)
> Thanks
> Brian
> On Wednesday 04 December 2002 4:48 pm, Dan Malek wrote:
>> Brian Waite wrote:
>> > ...Then I get the message No init found.
>>
>> First, try using something simple like /bin/bash as your init program.
>> Trying to start up the init program relies on lots of things being
>> present in the file system.  If the program starts, and then exits,
>> you still get this message.
>>
>> Just use a trivial, simple file system to get started.  A shell,
>> couple of commands and minimal libraries are easier to debug.
>>
>> Good luck :-)
>>
>> 	-- Dan
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
