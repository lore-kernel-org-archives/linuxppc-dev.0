Return-Path: <anton@ozlabs.org>
Date: Thu, 8 Mar 2007 21:31:41 -0600
From: Anton Blanchard <anton@samba.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Complain about missing system calls.
Message-ID: <20070309033141.GE24695@kryten>
References: <1173394873.3461.510.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1173394873.3461.510.camel@pmac.infradead.org>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, sam@ravnborg.org,
	linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

> Most system calls seem to get added to i386 first. This patch
> automatically generates a warning for any new system call which is
> implemented on i386 but not the architecture currently being compiled.
> On PowerPC at the moment, for example, it results in these warnings:

Love it!

...

> Thanks for the update. Quite why the PowerPC kernel defines system
> call numbers for all of these I have no idea :)

BTW while unistd.h may refer to sys_iopl etc, the actual syscall is sent
to ni_syscall in most of these useless cases.

Anton
