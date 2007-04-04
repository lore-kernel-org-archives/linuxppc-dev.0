Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <4612EA16.7070102@am.sony.com>
References: <1175208237.3122.78.camel@pmac.infradead.org>
	<1175636904.10567.8.camel@shinybook.infradead.org>
	<4612D8FE.1070400@am.sony.com> <200704040055.36173.arnd@arndb.de>
	<4612EA16.7070102@am.sony.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f0b0566265841de14815441f186fa690@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH] Ignore memory listed in PS3 device tree
Date: Wed, 4 Apr 2007 13:43:15 +0200
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, nhorman@redhat.com,
	cbe-oss-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	Ben Collins <ben.collins@ubuntu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I want
> to have a single kernel that can be either programmed into flash or 
> loaded
> by kexec.  For that to work the DT setup must be done in the wrapper, 
> or
> the kernel itself.

Do it in the bootwrapper please.  That way, the kernel
doesn't have to special-case this for PS3; also, it more
logically belongs there than in the kernel.


Segher
