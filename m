Subject: Re: DVI External Monitor on TiBook IV
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: daRonin <daronin@digimerc.com>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.53.0302131535570.1429@daronin.digimerc.com>
References: 
	 <Pine.LNX.4.44.0302101721560.23854-100000@zirkon.biophys.uni-duesseldorf.de>
	 <1044898053.10697.27.camel@thor>
	 <Pine.LNX.4.53.0302131535570.1429@daronin.digimerc.com>
Content-Type: text/plain
Message-Id: <1045220800.1122.22.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Date: 14 Feb 2003 12:06:40 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2003-02-13 at 23:52, daRonin wrote:
> I am running with external Cinema 23" display on my TiBook IV (Radeon
> Mobility 9000).
>
> The combination works great with earily 2.4.20 kernels, however with
> 2.4.20-ben5 my LCD stays on and goes white.
>
> I managed to determine that LCD is not turned on by radeonfb, it turns own
> earlier in the boot process. So even with video=ofonly the LCD stays on.
>
> My knowledge of kernel workings is not sufficent to determine where
> exactely the problem occurs. I would appreciate any lead into the right
> direction...

Please send me your latest working version of radeonfb.c

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
