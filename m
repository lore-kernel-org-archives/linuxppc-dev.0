Content-Type: text/plain;
  charset="iso-8859-1"
From: Lauri Ojantakanen <lauri.ojantakanen@solidtech.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Booting sandpoint from ide disk
Date: Fri, 6 Sep 2002 11:02:58 +0300
References: <200209051316.19309.lauri.ojantakanen@solidtech.com> <3D777C99.97AF4D14@mvista.com>
In-Reply-To: <3D777C99.97AF4D14@mvista.com>
MIME-Version: 1.0
Message-Id: <200209061102.58480.lauri.ojantakanen@solidtech.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Instant need for booting from ide disk seem to have gone away :( Dink32 does
not start anymore at all. When I restart the machine nothing comes through
the serial cable (settings are correct). I have not touched to any board
switches. Red leds on the altimus board are as follows:

RAM: not active
ROM: not active
stat: not active

Others are active.

On sandpoint main power and standby power -leds are active.

Actually when I recycle the power I get just one totally random character to
minicom (does not happen everytime).

Any ideas?

//lauri

On Thursday 05 September 2002 18:47, Mark A. Greer wrote:
> Lauri Ojantakanen wrote:
> > Hi,
> >
> > does anyone have a good solution for booting sandpoint X3 (cpu 7410,
> > altivec supported) from ide hard disk? Dink32 does not seem to support
> > anything like that and ppcboot does not seem to support that CPU.
>
> If you want to stay with DINK, you can put the zImage in flash and set DINK
> up to automatically (or not) jump to where you put it.  The zImage will
> relocate itself, uncompress the kernel (in the proper location) and then
> boot.  With the correct cmdline, you can use an IDE disk partition for your
> root filesystem. Unless you hack DINK, you won't be able to boot a kernel
> actually sitting on the IDE disk, you have to put it in flash or get it
> into memory some other way first.  As others have already said, you can
> always use PPCBoot.
>
> Mark
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
