Message-Id: <200007070846.JAA05142@hyperion.valhalla.net>
Date: Fri, 07 Jul 2000 09:46:04 +0100
Subject: Re: Multi-boot advice.
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
CC: Ethan Benson <erbenson@alaska.net>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jul 7, 2000 Ethan Benson  wrote:
> On Fri, Jul 07, 2000 at 07:52:10AM +0100, Iain Sandoe wrote:
>> On Fri, Jul 7, 2000 Ethan Benson wrote:
>> > On Thu, Jul 06, 2000 at 09:38:38AM +0100, Iain Sandoe wrote:
>> >> Yea Hey first to Apple Drive setup (which at least these days will allow
>> >> most stuff to be set up) - and then to pdisk - to check it out.
>> >
>> > just don't create any linux partitions with apples drive setup, it
>> > won't work.  instead add up the sizes of all the planned linux
>> > parittions and create a placeholder HFS partition with apple drive
>> > setup, then delete it with pdisk and populate the freed space with the
>> > linux and bootstrap partitions.
>>
>> This is interesting.  I've seen (several times) the comment that the Apple
>> Drive Setup tool doesn't work for Linux.
>>
>> However, it certainly did for me (on the Lombard & on a 9600/233)... under
>> what circumstances does it fail?
>
> every time i tested it the following occured:
>
> * drive setup crashed
> * the partition tables were corrupt.
>
> its just good policy to use the native fdisk to create an OS'es
> partitions, on intel we must use DOS fdisk to create DOS/Win*
> partitions and linux fdisk for linux partitions, same with OpenBSD,
> FreeBSD etc.  powerpc is no different.

This is OK for the people on this list.  We are happy with text-only command
line interfaces (hell, I once wrote an entire app in assembler... but I
wouldn't want to do that ever again.)

However, if we want Linux to be extended to a wider audience the kind of
intuitive set up tool (like drive set-up) is going to be essential.

Someone should tell Apple if there's a problem - they seem to be willing to
support (at least) the existence of Linux & other OSs - unlike certain other
companie$

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
