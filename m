Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <49945B4F.4090204@am.sony.com>
Date: Thu, 12 Feb 2009 09:24:31 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Roel Kluin <roel.kluin@gmail.com>
Subject: Re: [PATCH] PS3 ps3av_set_video_mode() make id signed
References: <4972456C.1050301@gmail.com>
	<alpine.LRH.2.00.0901201018440.31271@vixen.sonytel.be>
	<4975F455.8020004@gmail.com>
In-Reply-To: <4975F455.8020004@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Roel Kluin wrote:
> Make id signed so a negative id will get noticed. Error out if
> ps3av_auto_videomode() fails.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
>  arch/powerpc/include/asm/ps3av.h |    2 +-
>  drivers/ps3/ps3av.c              |   16 ++++++++++++----
>  2 files changed, 13 insertions(+), 5 deletions(-)

Just FYI, I added this to ps3-linux.git, since it is not a
critical fix, I will submit for 2.6.30.

-Geoff
