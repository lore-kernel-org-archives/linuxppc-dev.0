Return-Path: <mgreer@mvista.com>
Date: Tue, 15 May 2007 17:32:16 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: arch/powerpc/sysdev: dumping ground or only for shared drivers?
Message-ID: <20070516003216.GA13296@mag.az.mvista.com>
References: <20070510200237.GA19756@mag.az.mvista.com>
	<20070510215730.GA25075@lixom.net>
	<17987.47155.935764.878634@cargo.ozlabs.ibm.com>
	<20070511170512.GH4452@austin.ibm.com>
	<FF6A6402-37F5-406F-9DA2-0C0D4D6E4D8B@kernel.crashing.org>
	<20070515220616.GB2433@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070515220616.GB2433@mag.az.mvista.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 15, 2007 at 03:06:16PM -0700, Mark A. Greer wrote:

> I like Paul's take as well and I don't like the idea of moving the
> 5200 pci code, etc. to sysdev.  I just can't explain why.

Actually..."I have a doubt."

The more I think about it the more it makes sense to put the pic code,
etc. into sysdev (because of what Paul said).   It also makes it
easier when making wholesale changes (i.e., something changes in the
irq infrastructure and all the pic files need to be changed).
Its also easier to compare all the pic files, say, to see which ones
need cleaning up.

When all of the factoring, etc. that we're doing is complete, we may
find that our platform files are very small and we'll no longer need
all the directories under platforms.

[See, if I change my mind, Olof can't say I'm using his argument anymore ;)]

Time for me to stfu.

Mark
