Message-ID: <E1836A7F3557D311A14000805F9F36FC0141C740@usdfo011.usac.danfoss.net>
From: Hihn Jason <JasonHihn@DANFOSS.com>
To: "'Tim Lai'" <laitingwai@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: Can I run Linux without a file system?
Date: Fri, 21 Jun 2002 21:22:16 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


There are people here who can help you more than I, but I'll take a gander.
This is what I believe to be correct:
Yes. You will always have SOME kind of filesystem. But this begs another
question. How much do you know about Linux, and what are you really asking?
The /proc filesystem is not really on any disk, just like /dev (I think)
isn't on any disk, though they look like to us users that they are
filesystems.

If you want to run a program, where will it come from? There are filesystems
made for RAM, like cramfs or ramdisks, or flash filesystems complete with
wear-leveling. Maybe you can just jump to an offset and start executing code
if all you have is just a kernel and a program. If that is the case then
maybe you'll have to call your program 'init' or change the source of the
kernel to invoke your program.

Does this help?

I reserve the right to be wrong.


-----Original Message-----
From: Tim Lai [mailto:laitingwai@yahoo.com]
Sent: Friday, June 21, 2002 11:09 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Can I run linux without a file system?



I am porting linux on a custom board.
I am using the bootrom to load vmlinux onto
RAM, and I am in the middle of getting the console/
serial driver to work.
All the documents I read have refer the console as
/dev/ttyS, and state that to communicate to the
console, I have to set it up with open("/dev/ttyS").

Does that means I have to have some sort of file
system in linux?

Thanks.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
