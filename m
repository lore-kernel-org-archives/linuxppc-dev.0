Date: Thu, 13 May 2004 10:26:09 +0200
From: Cedric Pradalier <cedric.pradalier@inrialpes.fr>
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: diff between radeonfb.c and aty/radeon_base.c
Message-Id: <20040513102609.021d0fce.cedric.pradalier@inrialpes.fr>
In-Reply-To: <1084422549.13731.86.camel@gaston>
References: <20040512135950.4e6180ae.cedric.pradalier@inrialpes.fr>
	<1084422549.13731.86.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


According to Benjamin Herrenschmidt, on Thu, 13 May 2004 14:29:09 +1000,

>
>> Note the ordering difference between ifdef and surface_cntl=0.
>>
>> Is this normal ? As far as i can see, this means that surface_cntl is
>> not initialized on ibook with radeonfb.
>
>iBooks have __BIG_ENDIAN set ;)

Oops. I'll think I'll never get use to the meaning of this big and
little.

>
>> I'll try to change and report.
>
>The yellowish tint is an XFree bug afaik,

Oh, I understood they where linked to the radeonfb surface_cntl
parameter in my archive browsing. Anyway, the report is that as
expected, this does not change anything.

> are you using the DRI snapshots ? They have a fix.

I'm using M. Daenzer dri-trunk server and the patch to read PLL values
from openfirmware. The strange thing is  that the yellowish tint only
appear in dual-headed mode (bi-display or xinerama) with dri disabled.
No problem in mergedfb mode where dri is enabled.

So I guess there is an initialization in dri which is needed in non-dri
mode. I'll try to have a look at that.

>
>Ben.
>
>
>


--
Cedric

"[Of course] I'm French! Why do think I have this outrageous
accent, you silly king-a?!"  Monty Python and the Holy Grail

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
