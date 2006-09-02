Return-Path: <roto@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 023DF67BB8
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Sep 2006 09:27:02 +1000 (EST)
Date: Sun, 3 Sep 2006 01:26:44 +0200
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: Broken Firewire 400/SCSI on ppc Powerbook5,8
Message-ID: <20060902232644.GB2814@localhost>
References: <20060817230347.GC3440@localhost> <20060818234930.GB2662@localhost>
	<44E6D634.3000207@s5r6.in-berlin.de>
	<20060823002801.GA2709@localhost> <20060824192200.GA2715@localhost>
	<44F9D8EF.6010101@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <44F9D8EF.6010101@s5r6.in-berlin.de>
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

On Sat, Sep 02, 2006 at 09:18:07PM +0200, Stefan Richter wrote:
> 
> Alas I am out of ideas. Perhaps you should purchase a new enclosure. 
> Before you do that, you could test the AluBook running Linux and TiBook 
> in target disk mode again to exclude the possibility of problems at the 
> AluBook's side. Use "hdparm -tT /dev/sda" to try a few actual block read 
> operations. This should show about 20 MByte/s. It is a read-only test 
> and therefore safe.

OK, I did this test with the unmounted Tibook /dev/sda  
(target mode). So I executed the one-liners below on the
alubook. /dev/sda should be the hard disk on the tibook:

####################################################

# /sbin/hdparm -tT /dev/sda

/dev/sda:
 Timing cached reads:   1244 MB in  2.00 seconds = 620.49 MB/sec
 Timing buffered disk reads:   34 MB in  3.02 seconds =  11.24 MB/sec
[root@ 01:21:02]# /sbin/hdparm -tT /dev/sda

/dev/sda:
 Timing cached reads:   1232 MB in  2.00 seconds = 615.19 MB/sec
 Timing buffered disk reads:   34 MB in  3.04 seconds =  11.17 MB/sec
[root@ 01:21:20]# /sbin/hdparm -tT /dev/sda

/dev/sda:
 Timing cached reads:   1260 MB in  2.00 seconds = 628.93 MB/sec
 Timing buffered disk reads:   36 MB in  3.07 seconds =  11.72 MB/sec
[root@ 01:21:35]#

##############################################################

Looks good, doesn't it?

Thanks again

Best Regards
Wolfgang

-- 
Wolfgang Pfeiffer: /ICQ: 286585973/ + + +  /AIM: crashinglinux/
http://profiles.yahoo.com/wolfgangpfeiffer

Key ID: E3037113
http://keyserver.mine.nu/pks/lookup?search=0xE3037113&fingerprint=on
