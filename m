Return-Path: <gvb.linuxppc.dev@gmail.com>
Message-ID: <462104B1.3000504@gmail.com>
Date: Sat, 14 Apr 2007 12:43:29 -0400
From: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
MIME-Version: 1.0
To: Linuxppc-dev@ozlabs.org
Subject: Re: [PATCH dtc] Implement the -R option and add a -S option.
References: <20070405020433.GA13891@dellserver.lan>	<20070405161113.GA28063@ld0162-tx32.am.freescale.net>	<46152D90.5070209@smiths-aerospace.com>	<20070412065152.GA26210@localhost.localdomain>
	<4620D009.1000800@gmail.com>
In-Reply-To: <4620D009.1000800@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jerry Van Baren wrote:

[snip]

> On an unrelated related note, I don't believe my -R additions are 
> actually putting out additional reserve map slots (easiest to see using 
> the asm format output).  I'm still trying to understand why not, it 
> seemed pretty straight-forward.  When I implemented it, I was looking at 
> hexdumps of the dtb binary format and looking at the header and thought 
> I had it working... using it with my u-boot mods shows no extra reserved 
> slots.  I'm looking into where I went wrong.

OK, I didn't add a reserve additional slots output in the asm emission 
code, so that was a pretty simple fix.  I'll provide a patch after a bit 
more testing.

gvb
