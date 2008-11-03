Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40811030741o4d9490a3o3b23b9d69201c26a@mail.gmail.com>
Date: Mon, 3 Nov 2008 08:41:43 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: USB support on mpc5200 broken
In-Reply-To: <9e4733910809241809r58bddc2ax4759b70c3f07f6cf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910809241451x7492d2a9s56b4cb4ee0fe0244@mail.gmail.com>
	<9e4733910809241809r58bddc2ax4759b70c3f07f6cf@mail.gmail.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 24, 2008 at 6:09 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> On Wed, Sep 24, 2008 at 5:51 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>> USB is not working my hardware, so I booted my Efika and it's not
>> working there either.  This is with linus' current git.
>>
>> Can anyone verify this? Or know what happened to USB?
>> USB is loading but it is not finding anything plugged in.
>> lsusb doesn't show anything.
>>
>> Last time I noticed it was working was about ten days ago. I don't use
>> it everyday.
>
> Efika is broken because of this:
>
> ohci-ppc-of.c...
>        is_bigendian =
>                of_device_is_compatible(dn, "ohci-bigendian") ||
>                of_device_is_compatible(dn, "ohci-be");
>
> Efika doesn't have either of those in it's compatible string.

I finally got my Efika out and booted again.  I do not see this issue.

My efika shows compatible = "ohci-bigendian", "ohci-be",
"mpc5200-ohci", "mpc5200-usb";

I'm running stock firmware without any forth scripts.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
