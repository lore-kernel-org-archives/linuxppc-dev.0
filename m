Return-Path: <jonsmirl@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.229])
	by ozlabs.org (Postfix) with ESMTP id 21B92DDE1F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 13 Sep 2008 08:44:00 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id s6so555799wxc.15
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Sep 2008 15:43:58 -0700 (PDT)
Message-ID: <9e4733910809121543qe1325c6ya6b9218e87e39b7@mail.gmail.com>
Date: Fri, 12 Sep 2008 18:43:58 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Michael Carey" <MCarey@nearfield.com>
Subject: Re: Support for multiple consoles
In-Reply-To: <48CA8840.9124.0071.0@nearfield.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <48CA8840.9124.0071.0@nearfield.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Sep 12, 2008 at 6:18 PM, Michael Carey <MCarey@nearfield.com> wrote:
> Hi All,
>
> I am using ELDK 3.1.1 on a mpc5200 platform with a CoralP pci card.  I also connecting a keyboard and mouse.  When I compile the code without a virtual console, then my terminal session rules.  I can type with my terminal keyboard and everything seems fine.
>
> When I compile with a virtual console, then my embedded lcd displays text and my usb keyboard works.  Everything is great.
>
> Is there a way to switch back and forth between my embedded console to my terminal console?  I have tried console=ttyS0, but that does not seem to do anything.
> When I list my devices: 'ls /dev' I only get tty, ttyS0, ttyS1, and ttyS2.  I do not see a tty0.
>
> Is there a way to run multiple consoles on this configuration? If not, does to ELDK 4.x support this?

You should be able to get both consoles working. You probably aren't
running a login process on the second console. I haven't done this
recently, but reading about getty should give you some clues. This
used to be controled through inittab but inittab is gone on my desktop
so I don't know what controls it anymore.

>
>
> Thanks in advance for any information or guidance.
>
> Michael Carey
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>



-- 
Jon Smirl
jonsmirl@gmail.com
