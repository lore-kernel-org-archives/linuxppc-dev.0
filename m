Return-Path: <mgreer@mvista.com>
Message-ID: <422C8E3F.1000909@mvista.com>
Date: Mon, 07 Mar 2005 10:24:15 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Sven Luther <sven.luther@wanadoo.fr>
References: <422C495B.8090805@katalix.com>	<20050307125808.6585A200008A@mwinf0308.wanadoo.fr>
	<20050307132003.GA21030@pegasos>
In-Reply-To: <20050307132003.GA21030@pegasos>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Nicolas DET <det.nicolas@free.fr>, linuxppc-embedded@ozlabs.org,
	linuxppc-dev@ozlabs.org
Subject: Re: mv64x60 updates
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sven Luther wrote:

>I have appended a (slightly revised) version of the patch, which is against a
>saturday/sunday checkout of bk://dfarnsworth.bkbits.net/linux-2.5-mv643xx-enet, 
>which is what Mark and Dale are working on. Viewed like that the patch is
>against to really manageable size, altough it may need some fine-tuning. The
>rest of your comments probably apply to Dale's and Mark's work in the above
>tree though.
>  
>

Hi guys.  I got in late today so I'm just reading this thread now.

I basically want to reiterate and expand on what Brian 
<linwoes@gmail.com> stated.

The arch/ppc/syslib/mv64x60* code is really for embedded systems only.  
More accurately, its for systems whose firmwares don't do a good job of 
configuring the bridge or if you want to significantly change that 
configuration.  This ends up including many embedded systems but 
basically no "desktop"-like systems (e.g., ones with openfirmware) so 
that's why this thread should stay on linuxppc-embedded only.

Sven, et. al., your system has openfirmware and apparenly does a very 
good job of configuring the bridge so just ignore the mv64x60 stuff.  
You can use the platform_data code from there as an example of what 
needs to be passed into the enet driver (and mpsc & i2c & wdt, if you 
use them (and find all the patches :)).

If I missed something or you have any more questions, I'l be happy to help.

Mark
