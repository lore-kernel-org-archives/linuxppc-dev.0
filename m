From: Benjamin Herrenschmidt <bh40@calva.net>
To: "Hendricks, Kevin" <khendricks@ivey.uwo.ca>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: asm statement in include/asm not ansi conform
Date: Fri, 1 Sep 2000 17:25:36 +0200
Message-Id: <20000901152536.2290@mailhost.mipsys.com>
In-Reply-To: <v03110701b5d574d6d0ea@[129.100.29.243]>
References: <v03110701b5d574d6d0ea@[129.100.29.243]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I submitted that patch to Brad and Anthony so that it would make it into
>the official kernel trees and made and posted an XF86 4 patch to the
>mailing lists awhile back but but it does not seem to have made it into all
>XF86 trees.
>
>I can probably dig up that patch on my home machine and send it to the
>mailing list again if anyone wants it.

The patch have long been in the PPC RPMs produced by Howarth and Franz.
It was not merged in the main tree since we wanted to actually check if
there's an x86 card there with a valid BIOS ROM image, and no-one found
the time to do it.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
