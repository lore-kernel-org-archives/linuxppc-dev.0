Return-Path: <SRS0+1020516fb0ec803710a0+1314+infradead.org+dwmw2@canuck.srs.infradead.org>
Subject: Re: [PATCH] Implement check_legacy_ioport() on PS3
From: David Woodhouse <dwmw2@infradead.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070330014542.GA28342@lixom.net>
References: <1175212972.3122.87.camel@pmac.infradead.org>
	<20070330014542.GA28342@lixom.net>
Content-Type: text/plain
Date: Fri, 30 Mar 2007 02:43:07 +0100
Message-Id: <1175218987.3122.106.camel@pmac.infradead.org>
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

On Thu, 2007-03-29 at 20:45 -0500, Olof Johansson wrote:
> I ran into the very same thing earlier myself and had exactly the same
> idea. However, it turned out then that it would have meant adding more
> cases of ioport being allowed than it would have removed the opposite. It
> might have changed since then. Either way it's annoying. 

Perhaps we could set it to (void *)-1 to always return -ENODEV?

-- 
dwmw2
