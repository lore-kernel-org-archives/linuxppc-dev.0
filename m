Return-Path: <broonie@opensource.wolfsonmicro.com>
Date: Mon, 13 Sep 2010 09:25:42 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 11/11] sound: Remove pr_<level> uses of KERN_<level>
Message-ID: <20100913082542.GB16606@rakim.wolfsonmicro.main>
References: <cover.1284267142.git.joe@perches.com>
	<27a88f64b5bfec16c8abf5aca89b7a1b7533ecb9.1284267142.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <27a88f64b5bfec16c8abf5aca89b7a1b7533ecb9.1284267142.git.joe@perches.com>
Cc: cbe-oss-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
	Jiri Kosina <trivial@kernel.org>,
	Geoff Levand <geoff@infradead.org>, linux-kernel@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
	linuxppc-dev@lists.ozlabs.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Sep 11, 2010 at 10:10:59PM -0700, Joe Perches wrote:
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  sound/ppc/snd_ps3.c         |    2 +-
>  sound/soc/s3c24xx/s3c-dma.c |    3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
