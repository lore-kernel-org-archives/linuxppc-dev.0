Message-Id: <200005251832.UAA00645@piglet.grunz.lu>
Date: Thu, 25 May 2000 20:32:56 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Promise Ultra/66
To: spiette@generation.net
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20000524143917.I1169@xim.bellglobal.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Simon,

On  24 May, this message from Simon Piette echoed through cyberspace:
>> > Great! It's working without a hitch (but with a few kernel args!).
>>
>> Which ones are those? I need none; I could do with idebus=xx for bus
>> frequency; but the default is ok...
>
> I use an IMS TwinTurbo card driver that I can't get to work in 2.2.15, so I'm
> stuck with 2.2.12. I've had to add some hde=noautotune and
> hde=4092,13,63 for an old Seagate ST32122A. None of those was needed
> with 2.2.15.

I've never had those problems with my Maxtor disk....

>> > I have to say that I can't put my card in slot 3 or 4, but only in 1 or
>> > 2. Not an issue for me but you may want to know ...
>>
>> What was your machine again? There might be an issue either with bus
>> mastering (some brain-dead designs don't allow bus masters in all slots;
>> the Promise is a bus master) or with multiple PCI buses. In the first
>> case there's nothing you can do; in the second case I might have screwed
>> up my patches....
>
> It's a Umax J700/180. lspci:
>
> 00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev 03)
> 00:0d.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown device 4d38 (rev 01)
> 00:0e.0 Display controller: Integrated Micro Solutions Inc. IMS9129 (rev 01)
> 00:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21052 (rev 01)

Aha. I suppose this bridge goes to bus 2, with slots 3 and 4. Either the
PCI code doesn't (for some unknown reason) support that bus, or it is
not master-capable. Can you send an lspci with some card in slot 3 or 4?

> 00:10.0 Class ff00: Apple Computer Inc. Grand Central I/O (rev 02)

Thanks

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
