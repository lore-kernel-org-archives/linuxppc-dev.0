Return-Path: <roto@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id BE6A467C2A
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 10:36:11 +1000 (EST)
Date: Wed, 23 Aug 2006 02:36:38 +0200
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: Broken Firewire 400/SCSI on ppc Powerbook5,8
Message-ID: <20060823003638.GB2709@localhost>
References: <20060817230347.GC3440@localhost> <20060818234930.GB2662@localhost>
	<44E6D634.3000207@s5r6.in-berlin.de>
	<20060823002801.GA2709@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060823002801.GA2709@localhost>
Cc: linuxppc-dev@ozlabs.org, billfink@mindspring.com,
	linux1394-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 23, 2006 at 02:28:01AM +0200, Wolfgang Pfeiffer wrote:

> [ ... ]

> Some tests on the Alubook:
> 
> I compiled a fresh git kernel now with verbose ieee logging turned on.
> 
> $ uname -r
> 2.6.18-rc4-ieeeverbose-gef7d1b24-dirty
> 
> $ zgrep 4_VERBOS /proc/config.gz 
> 
>   [ ..... ]
> 
> Only after running the latter script, I switch on the FW disk. The log
> for these moments covering about 60 seconds is here:
> 
> wolfgangpfeiffer.com/kern.log.when.fw.disk.is.switched.on.txt
> 
> Then, some time later on with no /dev/sda available, I run gscanbus,
> forcing a bus reset. The log, again covering about 60 seconds is here:
> 
> wolfgangpfeiffer.com/kern.log.with.gscanbus.after.failed.fw.connection.txt


Sorry, forgot that: After running gscanbus above, and a few minutes after
sending the quoted message: still no /dev/sda

Regards
Wolfgang 

-- 
Wolfgang Pfeiffer: /ICQ: 286585973/ + + +  /AIM: crashinglinux/
http://profiles.yahoo.com/wolfgangpfeiffer

Key ID: E3037113
http://keyserver.mine.nu/pks/lookup?search=0xE3037113&fingerprint=on
