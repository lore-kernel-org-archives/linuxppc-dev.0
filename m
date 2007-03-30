Return-Path: <SRS0+1020516fb0ec803710a0+1314+infradead.org+dwmw2@canuck.srs.infradead.org>
Subject: Re: [Cbe-oss-dev] [PATCH] Ignore memory listed in PS3 device tree
From: David Woodhouse <dwmw2@infradead.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <460D4BC3.8030805@am.sony.com>
References: <1175208237.3122.78.camel@pmac.infradead.org>
	<460D4BC3.8030805@am.sony.com>
Content-Type: text/plain
Date: Fri, 30 Mar 2007 18:45:28 +0100
Message-Id: <1175276728.3122.161.camel@pmac.infradead.org>
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

On Fri, 2007-03-30 at 10:41 -0700, Geoff Levand wrote:
> The proper way is to parse out just the command line from the incompatible
> DT, and use that with the new DT supplied by the bootwrapper.  I planed
> to do that in my bootwrapper, but haven't coded it yet. 

There is no bootwrapper here. We boot a plain vmlinux, which needs to
cope. If it needs fixing up beforehand, it needs to be done in kexec.

-- 
dwmw2
