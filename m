Return-Path: <roto@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id AFDC067B91
	for <linuxppc-dev@ozlabs.org>; Sat, 20 May 2006 00:38:09 +1000 (EST)
Date: Fri, 19 May 2006 16:40:28 +0200
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: snd-aoa status update / automatic driver loading
Message-ID: <20060519144028.GA2831@localhost>
References: <1147860564.14395.6.camel@johannes>
	<20060517215412.GA4504@localhost> <20060517221945.GA2902@localhost>
	<1147947192.15507.40.camel@johannes>
	<20060518181748.GA2836@localhost>
	<1148043018.3864.6.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1148043018.3864.6.camel@johannes.berg>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 19, 2006 at 02:50:18PM +0200, Johannes Berg wrote:
> On Thu, 2006-05-18 at 20:17 +0200, Wolfgang Pfeiffer wrote:
> 
> > BTW: Is there a way to let 'alsaconf' detect the soundcard on this
> > PB5,8 ?
> > So far that's impossible, as it seems. But this could also be
> > related to mistakes I made in my modules files, or wherever.
> 
> No idea, but I don't see why you'd want alsaconf to figure it out 

... because it's the job of alsaconf, too, to figure that
out. IINM. And because I thought it might help to mention the issue,
when I was already at it .. :)

But yes, it does not bother me if the kernel itself knows what's going
on .. :)

Best Regards
Wolfgang


-- 
Wolfgang Pfeiffer: /ICQ: 286585973/ + + +  /AIM: crashinglinux/
http://profiles.yahoo.com/wolfgangpfeiffer

Key ID: E3037113
http://keyserver.mine.nu/pks/lookup?search=0xE3037113&fingerprint=on
