Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id B2CCEDDED0
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 02:35:20 +1100 (EST)
Date: Thu, 23 Oct 2008 17:35:10 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: adding more machines to snd-aoa
Message-ID: <20081023153510.GA28277@iram.es>
References: <1224769461.6002.12.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1224769461.6002.12.camel@johannes.berg>
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux User #330250 <linuxuser330250@gmx.net>,
	Sjoerd Simons <sjoerd@luon.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 23, 2008 at 03:44:21PM +0200, Johannes Berg wrote:
> Hi,
> 
> Andreas (Cc'ed) asked whether it was possible to use snd-aoa on his
> machine, a PowerMac3,6. It appears that it is fairly easy since the
> machine seems to use a regular i2sbus.
> 
> To identify it, after looking through my device-tree collections I think
> that the "device-id" property of the sound node would be the best bet.
> This is the value "22" for a PowerMac3,6.
> 
> However, this node is also present on at least a PowerBook5,2 (value
> 35). Can somebody who has such a machine please reply to this me?
> Sjoerd, I think you have/had such a machine? I'd like you to test a few
> patches once they're ready, and I need to know what connectors it has
> (line-in, mic, headphones, ...).
> 
> However, even if that works, I'll also need to know whether there are
> any other machines that have such a device-id property so that making
> snd-aoa-i2sbus aware of machines with device-id doesn't break those that
> I don't list. Therefore, if you have access to a machine that is
> newworld and has audio, please run the following commands:
> 
> find /proc/device-tree/ -wholename '*sound/device-id'
> find /proc/device-tree/ -wholename '*sound/device-id' | xargs hd
> 

On my almost 8 years old PowerMac (PowerMac3,4 accorfing to OF):

$ find /proc/device-tree/ -wholename '*sound/device-id' | xargs hd
00000000  00 00 00 0e                                       |....|
00000004

or 14 in decimal.

	Regards,
	Gabriel
