Return-Path: <geoff@infradead.org>
Message-ID: <1333597457.3726.3.camel@clam>
Subject: Re: [PATCH] powerpc/boot: Only build board support files when
 required.
From: Geoff Levand <geoff@infradead.org>
To: Tony Breeds <tony@bakeyournoodle.com>
Date: Wed, 04 Apr 2012 20:44:17 -0700
In-Reply-To: <20120403005558.GA9194@thor.bakeyournoodle.com>
References: <20120403005558.GA9194@thor.bakeyournoodle.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Frank =?ISO-8859-1?Q?Svendsb=F8e?= <frank.svendsboe@gmail.com>,
 Wolfgang Denk <wd@denx.de>, robert.karl.berger@gmail.com,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-04-03 at 10:55 +1000, Tony Breeds wrote:
> Currently we build all board files regardless of the final zImage
> target.  This is sub-optimal (in terms on compilation) and leads to
> problems in one platform needlessly causing failures for other
> platforms.
> 
> Use the Kconfig variables to selectively construct this board files to
> build.
> 
> +ifeq ($(CONFIG_PPC_PS3),y)
> +src-plat  += ps3-head.S ps3-hvcall.S ps3.c
> +endif

PS3 part looks good.

Acked-by: Geoff Levand <geoff@infradead.org>
