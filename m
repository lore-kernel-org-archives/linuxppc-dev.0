Message-ID: <3C458B66.7020704@cray.com>
Date: Wed, 16 Jan 2002 08:17:10 -0600
From: David Updegraff <dave@cray.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: a MINIMAL405 submodel
References: <3C44A4AF.9000302@cray.com> <3C44A85E.1090108@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

>
> David Updegraff wrote:
>
>> ... Might we be able to limit the proliferation of submodel
>> in the PPC 4xx world with the addition of my proposed MINIMAL405
>> submodel and then let vendors write drivers instead of kernels?
>
>
> The 8xx and 8260 are almost like this.  What you will discover over
> time is a driver you write is 99% of what someone else wants.  In your
> proposal, you would end up with a whole new driver that is almost identical
> to another, which isn't practical to maintain. Just follow the convention

> of adding a board descriptor for your platform.  If it is truly identical
> to another, then the platforms can share the same files and this knowledge
> is implicit in the configuration.  Now, if the current configurations make
> assumptions about platforms that use a 405GP (and it shouldn't), that is
> what needs to change.


I'm happy with that approach too: so we'd have a new board description of

a MINIMAL405. Or.. with some minor surgery to the WALNUT description, I
could fit in there (additional CONFIG_* things maybe to adjust presence
of peripherals and presumption of PPCBOOT vs. IBM-BIOS..).  It boils
down to almost same thing: a board defn. that can be configured down to
a peripheral-less 405gp.  I has assumed that my chances of lobbying
for a "new" board description might be a bit better than lobbying for
a bunch of changes to the WALNUT or EP405.  Though either of those
would work fine if they just consistently obeyed CONFIG_PCI,
CONFIG_RTC, CONFIG_NVRAM, CONFIG_VT, and we had a mechaninsm for
ppcboot cognizance of board_t.  Infact, it looks to me like they could
be merged in that case..

Please advise.

--
Dave Updegraff / dave@cray.com / 218-525-1154


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
