Return-Path: <SRS0+1020516fb0ec803710a0+1314+infradead.org+dwmw2@canuck.srs.infradead.org>
Subject: Re: [Cbe-oss-dev] [PATCH] Ignore memory listed in PS3 device tree
From: David Woodhouse <dwmw2@infradead.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <3f028c6d87efaadfadee6894656ff220@kernel.crashing.org>
References: <1175208237.3122.78.camel@pmac.infradead.org>
	<460D4BC3.8030805@am.sony.com>
	<1175276728.3122.161.camel@pmac.infradead.org>
	<3f028c6d87efaadfadee6894656ff220@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 30 Mar 2007 19:13:47 +0100
Message-Id: <1175278427.3122.164.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-03-30 at 20:11 +0200, Segher Boessenkool wrote:
> Maybe you should use a bootwrapper, instead.
> 
> It doesn't make sense to duplicate lots of firmware
> and bootloader/bootwrapper functionality in the kernel
> just for kexec.  (Or to do that at all, really).

kexec has a --devicetreeblob option, if we need to resort to that.
And we're not talking about "lots of functionality". It's just a case of
ignoring the memory which is mentioned in the device-tree.

-- 
dwmw2
