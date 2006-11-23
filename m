Return-Path: <jes@trained-monkey.org>
Received: from jaguar.mkp.net (jaguar.mkp.net [192.139.46.146])
	by ozlabs.org (Postfix) with ESMTP id ED96067BE1
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 20:41:44 +1100 (EST)
Sender: jes@trained-monkey.org
To: Michael Schmitz <schmitz@mail.biophys.uni-duesseldorf.de>
Subject: Re: [RFC: 2.6 patch] remove broken video drivers
References: <20061118000235.GV31879@stusta.de>
	<Pine.LNX.4.58.0611181132230.7667@xplor.biophys.uni-duesseldorf.de>
From: Jes Sorensen <jes@sgi.com>
Date: 23 Nov 2006 04:08:29 -0500
In-Reply-To: <Pine.LNX.4.58.0611181132230.7667@xplor.biophys.uni-duesseldorf.de>
Message-ID: <yq0k61mv8c2.fsf@jaguar.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sammy@sammy.net, linux-m68k@vger.kernel.org,
	James Simmons <jsimmons@infradead.org>,
	linux-fbdev-devel@lists.sourceforge.net, sun3-list@redhat.com,
	linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>,
	linuxppc-dev@ozlabs.org, geert@linux-m68k.org, adaplas@pol.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Michael" == Michael Schmitz <schmitz@mail.biophys.uni-duesseldorf.de> writes:

Michael> On Sat, 18 Nov 2006, Adrian Bunk wrote:
>> This patch removes video drivers that: - had already been marked as
>> BROKEN in 2.6.0 three years ago and - are still marked as BROKEN.
>> 
>> These are the following drivers: - FB_CYBER - FB_VIRGE -
>> FB_RETINAZ3 - FB_ATARI

Michael> FB_ATARI has just been revived. Geert has a preliminary
Michael> patch; I'll send the final one soonish.

I'm probably the only one with a RetinaZ3 left but the machine hasn't
been booted for quite a while..... not sure if I'll get to it in the
near future, but I can always resurrect the patches from an old kernel
and start from there if I do.

Jes
