Return-Path: <tklauser@sym.noone.org>
Received: from sym.noone.org (symlink.to.noone.org [85.10.207.172])
	by ozlabs.org (Postfix) with ESMTP id DF7EEB70B2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 10 Sep 2011 00:48:54 +1000 (EST)
Date: Fri, 9 Sep 2011 11:49:52 +0200
From: Tobias Klauser <tklauser@distanz.ch>
To: Yong Zhang <yong.zhang0@gmail.com>
Subject: Re: [PATCH 54/62] TTY: irq: Remove IRQF_DISABLED
Message-ID: <20110909094952.GI11405@distanz.ch>
References: <1315383059-3673-1-git-send-email-yong.zhang0@gmail.com>
	<1315383059-3673-55-git-send-email-yong.zhang0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1315383059-3673-55-git-send-email-yong.zhang0@gmail.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>, linux-cris-kernel@axis.com,
	nios2-dev@sopc.et.ntust.edu.tw,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, Mikael Starvik <starvik@axis.com>,
	Jesper Juhl <jj@chaosbits.net>, linux-serial@vger.kernel.org,
	Jiri Kosina <jkosina@suse.cz>,
	uclinux-dist-devel@blackfin.uclinux.org, tglx@linutronix.de,
	Sonic Zhang <sonic.zhang@analog.com>,
	linuxppc-dev@lists.ozlabs.org, mingo@elte.hu,
	Alan Cox <alan@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2011-09-07 at 10:10:51 +0200, Yong Zhang <yong.zhang0@gmail.com> wrote:
> This flag is a NOOP and can be removed now.
> 
> Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>

For altera_jtaguart and altera_uart:

Acked-by: Tobias Klauser <tklauser@distanz.ch>
