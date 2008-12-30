Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910812301217n1d34a35ar5b4bbd32a3e4a74c@mail.gmail.com>
Date: Tue, 30 Dec 2008 15:17:55 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	"Grant Likely" <grant.likely@secretlab.ca>,
	"Anton Vorontsov" <avorontsov@ru.mvista.com>
Subject: mpc5200 spi + mmc support
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant, is your mpc5200 spi support going in this round? If so, there
is a small amount of dependent code to get mmc working.

Anton's of_mmc_spi.c patch is also needed. I'm not sure of the status
for that patch, it has gone through a lot of revisions.

-- 
Jon Smirl
jonsmirl@gmail.com
