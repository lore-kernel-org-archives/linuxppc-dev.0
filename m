Message-Id: <200007071016.LAA22162@hyperion.valhalla.net>
Date: Fri, 07 Jul 2000 11:16:18 +0100
Subject: Re: Drive Setup (was Multi-boot)
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
CC: Hollis Blanchard <hollis@amulet.co.jp>
Mime-version: 1.0
Content-type: text/plain; charset="ISO-2022-JP"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 07 Jul 2000 Hollis Blanchard wrote:
> Iain Sandoe wrote:
>>
>> On Fri, Jul 7, 2000 Ethan Benson  wrote:
> [snip]
>> >
>> > every time i tested it the following occured:
>> >
>> > * drive setup crashed
>> > * the partition tables were corrupt.
>> >
>> > its just good policy to use the native fdisk to create an OS'es
>> > partitions, on intel we must use DOS fdisk to create DOS/Win*
>> > partitions and linux fdisk for linux partitions, same with OpenBSD,
>> > FreeBSD etc.  powerpc is no different.
>
> [snip]
>
>>
>> Someone should tell Apple if there's a problem - they seem to be willing to
>> support (at least) the existence of Linux & other OSs - unlike certain other
>> companie$
>
> I have never had Drive Setup crash on me, not even once. To try to
> settle this question (not about stability, but about whether it produces
> Linux-acceptable partition maps), I've just used Drive Setup's
> unmodified "Preferred LinuxPPC" setting to partition a disk. The Mac OS
> is currently installing, and I expect no problems when I install Linux
> in 5 minutes.

I'm also going to try it when I get round to the G4 multi-boot install ;-)
Still doing dmasound backport...

will report back.

> The only complaint I have with Drive Setup is that it insists on erasing
> all partitions on the drive any time you want to make partition changes.
> Even newbies wondrously appreciating the beautiful Mac OS widgets in
> their partitioning utility will not want to reformat their entire hard
> disk.

Yes, we really need a MacOS "Partition Magic" or equivalent.  I wonder if
anyone on the list knows how to do it ;-)

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
