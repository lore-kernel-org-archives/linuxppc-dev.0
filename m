Return-Path: <geoff@infradead.org>
Message-ID: <1364603888.16937.62.camel@smoke>
Subject: Re: [PATCH for 3.9] powerpc/ps3: Update ps3_defconfig
From: Geoff Levand <geoff@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 29 Mar 2013 17:38:08 -0700
In-Reply-To: <1363655503.1075.40.camel@smoke>
References: <cover.1360810584.git.geoff@infradead.org>
 <1363655503.1075.40.camel@smoke>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

It would be nice if I could get this in for 3.9.  Did you miss it?

Thanks.

-Geoff

On Mon, 2013-03-18 at 18:11 -0700, Geoff Levand wrote:
> Refresh and set CONFIG_RD_LZMA=y.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
> Hi Ben,
> 
> This sets CONFIG_RD_LZMA=y, which is needed to boot with
> newer initrd images.
> 
> Please apply for 3.9.
> 
> Also available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/geoff/ps3-linux.git for-powerpc
> 
> -Geoff
