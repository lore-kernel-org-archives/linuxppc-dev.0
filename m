Return-Path: <avorontsov@ru.mvista.com>
Date: Tue, 30 Dec 2008 23:29:51 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: mpc5200 spi + mmc support
Message-ID: <20081230202951.GA9563@oksana.dev.rtsoft.ru>
References: <9e4733910812301217n1d34a35ar5b4bbd32a3e4a74c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <9e4733910812301217n1d34a35ar5b4bbd32a3e4a74c@mail.gmail.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 30, 2008 at 03:17:55PM -0500, Jon Smirl wrote:
> Grant, is your mpc5200 spi support going in this round? If so, there
> is a small amount of dependent code to get mmc working.
> 
> Anton's of_mmc_spi.c patch is also needed. I'm not sure of the status
> for that patch, it has gone through a lot of revisions.

Few hours ago I posted of_mmc_spi to Pierre.

http://lkml.org/lkml/2008/12/30/130

Plus we'll need modalias update to actually enable it:

http://patchwork.ozlabs.org/patch/12501/

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
