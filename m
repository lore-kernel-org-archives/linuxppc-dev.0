Date: Thu, 23 Sep 1999 18:22:23 -0500
From: Shaw Terwilliger <sterwill@io.nu>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel with sleep support
Message-ID: <19990923182223.A1364@io.nu>
References: <19990922181248.018729@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19990922181248.018729@mailhost.mipsys.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
> Due to popular demand, I've posted a kernel with sleep support (a few
> more patches than the stock rsync kernel from Paul) along with the diffs to:

I've built my own kernel from paul's rsync archives (from about the
date of your message) and your diffs.  Unfortunately, the kernel
boots and crashes in 'swapper' on my Lombard:

Kernel panic: kernel access of bad area pc c01513b4 lr c0151374 address F3000034 tsk swapper/1

It crashes here every boot.  The same kernel tree (paul's rsync) builds 
a kernel that runs fine (without the patches).

-- 
Shaw Terwilliger (sterwill@io.nu)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
