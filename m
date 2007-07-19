Return-Path: <rene.herman@gmail.com>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200]) by ozlabs.org (Postfix) with ESMTP id BD2F8DDEE1
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 04:26:13 +1000 (EST)
Message-ID: <469FA5E5.3070301@gmail.com>
Date: Thu, 19 Jul 2007 19:56:53 +0200
From: Rene Herman <rene.herman@gmail.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 2/3] ps3: BD/DVD/CD-ROM Storage Driver
References: <20070716161539.075822000@pademelon.sonytel.be>	<20070716162206.529280000@pademelon.sonytel.be>	<20070718164351.a92ec032.akpm@linux-foundation.org>	<Pine.LNX.4.62.0707191100270.8661@pademelon.sonytel.be>	<20070719021752.35cb7daa.akpm@linux-foundation.org>	<Pine.LNX.4.62.0707191137470.8661@pademelon.sonytel.be>
	<20070719024730.03609f1f.akpm@linux-foundation.org>
In-Reply-To: <20070719024730.03609f1f.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: Jens Axboe <axboe@kernel.dk>,
	"James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 07/19/2007 11:47 AM, Andrew Morton wrote:

> On Thu, 19 Jul 2007 11:39:32 +0200 (CEST) Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> 
>>> Oh dear.
>>>
>>> 	ps3rom_priv(dev) = host;
>>>
>>> that's 'orrid.  We have an identifier pretending to be a function, only we
>>> go and treat it as an lvalue.
>>>
>>> I mean, C code should look like C code, and the above just doesn't.
>>>
>>> Sigh.

You could insist that it be PS3ROM_PRIV() because then it at least also 
_looks_ like cpp...

Rene.
