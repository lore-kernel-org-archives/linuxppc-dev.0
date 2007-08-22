Return-Path: <mroos@linux.ee>
Date: Wed, 22 Aug 2007 14:50:07 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
Sender: mroos@math.ut.ee
To: linuxppc-dev@ozlabs.net
Subject: How to port PReP to arch/powerpc?
Message-ID: <Pine.SOC.4.64.0708221444510.5639@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It seems no one cares for arch/ppc any more but the move to powerpc was 
not finished completely (PReP subarch was not migrated but sees users, I 
do not know about the user base of the other subarches). So I have been 
thinking about migrating PReP support to arch/powerpc myself since I use 
it.

Any general guidelines or specific hints about that? I have looked 
around in the code and some pieces are clearly PReP specific (setup, 
pci, boot) but others seem wuite a bit mixed up with other subarches.

-- 
Meelis Roos (mroos@linux.ee)
