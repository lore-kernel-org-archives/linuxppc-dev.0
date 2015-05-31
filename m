Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1477B1A0072
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2015 09:30:35 +1000 (AEST)
Date: Mon, 1 Jun 2015 08:30:19 +0900
From: Wolfram Sang <wsa@the-dreams.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: Dan DeVoto <dand1972@yahoo.com>, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 alsa-devel@alsa-project.org, linux-i2c@vger.kernel.org,
 Mark Elliott <txlitebeer@gmail.com>
Subject: Re: [alsa-devel] [RFC] sound: ppc: keywest: check if DEQ was already
 instantiated
Message-ID: <20150531233018.GC17187@katana>
References: <1432397711-3186-1-git-send-email-wsa@the-dreams.de>
 <1432631974.85649.YahooMailBasic@web141501.mail.bf1.yahoo.com>
 <s5htwuxb1h4.wl-tiwai@suse.de> <20150529105020.GB3168@katana>
 <s5hsiaf6489.wl-tiwai@suse.de> <20150529110559.GB4282@katana>
 <s5hoal3621l.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <s5hoal3621l.wl-tiwai@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 29, 2015 at 01:44:38PM +0200, Takashi Iwai wrote:
> At Fri, 29 May 2015 20:06:09 +0900,
> Wolfram Sang wrote:
> > 
> > > Do you think from which stable kernel version can this be applied?
> > 
> > The offending commit is 3a3dd0186f619b74e61e6f29dddcaf59af7d3cac
> > ("i2c/powermac: Improve detection of devices from device-tree") which
> > came in with v3.6 if I read correctly.
> 
> OK, thanks!

Just to make sure: Keep in mind that it depends on "sound: ppc: keywest:
drop using attach adapter" which needs to go to stable, then, too.
