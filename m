Return-Path: <roto@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 51FCF679E7
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 12:17:56 +1000 (EST)
Date: Mon, 29 May 2006 04:17:56 +0200
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: [Done] Re: snd-aoa: Sound gone after snd-aoa updates, on PB5,8
Message-ID: <20060529021756.GB3107@localhost>
References: <20060529020027.GA3107@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060529020027.GA3107@localhost>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 29, 2006 at 04:00:27AM +0200, Wolfgang Pfeiffer wrote:
> 
> Hi
> 
> After some updates from http://johannes.sipsolutions.net/snd-aoa.git/
> in the last few hours/minutes sound's gone here. Without changing
> sound settings intentionally here. 
> 
> 

On Debian/unstable:
After downgrading libasound2 from 1.0.11-6 to 1.0.11-3 I have sound
again: 1.0.11-6 was, IINM, installed a few hours ago, which
 - as it seems - broke sound here.

HTH

Wolfgang

-- 
Wolfgang Pfeiffer: /ICQ: 286585973/ + + +  /AIM: crashinglinux/
http://profiles.yahoo.com/wolfgangpfeiffer

Key ID: E3037113
http://keyserver.mine.nu/pks/lookup?search=0xE3037113&fingerprint=on
