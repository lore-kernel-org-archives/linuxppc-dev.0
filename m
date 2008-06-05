Return-Path: <roto@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id C0789DE00E
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 08:58:15 +1000 (EST)
Date: Fri, 6 Jun 2008 00:58:07 +0200
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Jens Axboe <jens.axboe@oracle.com>
Subject: git Linux 2.6.26-rc5 - 53c8ba9: seems OK after short use
Message-ID: <20080605225807.GA3642@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi All

With these rather fresh sources, obtained via git: 

53c8ba9 Linux 2.6.26-rc5 

and after just about an hour of mild tests on 2 powerpc laptops: an
older TiBookIV, a newer Powerbook5,8.

CD-Burning seems to work again: at least on the Powerbook5,8 - with a
real image burn. A simulated CD burn on the TiBookIV ended
successfully.

Sleep seems being OK, on both machines.

Trackpad mouse pointer, on both machines, didn't disappear so far.

I only realised yesterday, after months of using a kernel that I even
uploaded for the rest of the world around Febr./March this year, that
CD burning obviously was gone with v2.6.25-rc3-81-g7704a8b. So after a
short test this burner issue seems gone with the new 2.6.26-rc5 .. :)

And no, I won't upload this 2.6.26-rc5 package anywhere, probably ...

Thanks a lot to the kernel guys ... :)

HTH
Wolfgang
-- 
http://heelsbroke.blogspot.com/
http://keyserver.mine.nu/pks/lookup?search=0xE3037113&fingerprint=on
