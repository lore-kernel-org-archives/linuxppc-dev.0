Date: Thu, 04 Jan 2001 11:26:06 +0100
Subject: Re: Changes in the Valkyrie driver from 2.1.24 to 2.2.18
From: Chris Boot <bootc@worldnet.fr>
To: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B67A0BF1.7EFB%bootc@worldnet.fr>
In-Reply-To: <3A541B7F.98ABCD9D@wanadoo.fr>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Geert Uytterhoeven wrote:
>
>> On Wed, 3 Jan 2001, Chris Boot wrote:
>>> It has struck me, after weeks of research, that my problems in booting my
>>> 5400/180 cold through OpenFirmware are caused by changes in the Linux
>
> Chris, are you trying to boot with Quik? This, in fact, stopped working
> on the 5400/6400 around kernel 2.1.125, IIRC. What's wrong with using
> BootX?

Well, I was hoping not to have any Mac OS on this machine except a
full-blown Mac OS 9 when needed.  This would allow me to Quik-boot Linux and
set OF to use /AAPL,ROM when needed through my serial console.  I don't
believe I can choose between booting Linux/Mac OS in any other system using
a serial console (only built-in monitor).

>>>
>>> My suspicions were aroused when, after disabling CONFIG_FB, the machine
>>> booted cold without any problems whatsoever.
>
> And what display?

Well, I usually use the built-in one, but when I disabled CONFIG_FB, I
didn't use a display, I just used my serial console / telnet.

>>>
>>> Is it at all possible to use Valkyrie without going through OpenFirmware at
>>> all?  It is not selectable if I disable CONFIG_FB_OF.  Would it be possible
>>> to port the older non-OF driver to the newer kernel?  What are the
>>> disadvantages of using the older memory-based driver to the newer OF-based
>>> driver?
>>
>> Have you tried 2.4.0-testX yet?
>>
>> In 2.4.0-testX, valkyriefb is initialized without the help of offb.
>> I don't have a 2.2.18 tree at hand, but you can probably use a similar method
>> in 2.2.18 with some hacking (call valkyriefb_init() from
>> drivers/video/fbmem.c,
>> and not offb_init()).
>
> Geert, this modification is contained in the 2.2.18 kernels from bk and
> from Paul. It just didn't make it into the official 2.2.18 tree. But
> most users of valkyrie probably don't care anyway.

I haven't tried the 2.4 tree because I didn't know how reliable it was.  I
guess it's time to try it now.  How/where do I get it?

You say that these changes didn't make it into the kernel.org tree, but
where do I get the BK images?  Is there a way of getting it through
FTP/HTTP?

Thanks,

--
    .-.        Chris Boot
    /v\     bootc@worldnet.fr
   // \\
  /(   )\   L   I   N   U   X
   ^^-^^   >Phear the Penguin<


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
