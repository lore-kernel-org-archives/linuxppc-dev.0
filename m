Message-ID: <20000921180657.A25427@lx.c-side.com>
Date: Thu, 21 Sep 2000 18:06:57 -0700
From: Neil Russell <caret@c-side.com>
To: Jerry Van Baren <vanbaren_gerald@si.com>,
        linuxppc-embedded@lists.linuxppc.org
Cc: systemboot@linux01.hasler.ascom.ch
Subject: Re: Limon & PowerQUICC II
References: <0G1800HE5TPGL0@pmdf-it.hasler.ascom.ch> <4.3.2.20000921142722.00b8b720@falcon.si.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4.3.2.20000921142722.00b8b720@falcon.si.com>; from Jerry Van Baren on Thu, Sep 21, 2000 at 03:05:00PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Sep 21, 2000 at 03:05:00PM -0400, Jerry Van Baren wrote:
> >4. I have set IMMR to 0xF000000. Is that correct for limon?
>
> The reset config word is what sets the IMMR.  It has to agree with the
> limon's notion of where the IMMR is.  Beyond that, it is your
> choice.  The EST default value is 0x0F000000 which is unfortunately
> different from the linux convention.

Actually, limon will read the reset configuration word to find what the IMMR
should be, then changes it to 0xf0000000.  If you flash limon and have the
reset conf word right, all will be well.  If you download limon using the
vxWorks loader, then the reset conf word needs to set IMMR to 0x0f000000,
so the vxWorks loader and limon can agree.


Neil.


--
Neil Russell <caret@c-side.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
