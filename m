Return-Path: <benh@kernel.crashing.org>
Subject: [ANNOUNCE] petitboot git tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: cbe-oss-dev@ozlabs.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>
In-Reply-To: <200704052342.23662.jk@ozlabs.org>
References: <200704052342.23662.jk@ozlabs.org>
Content-Type: text/plain
Date: Fri, 06 Apr 2007 16:32:50 +1000
Message-Id: <1175841170.7407.6.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-04-05 at 23:42 +1000, Jeremy Kerr wrote:
> Hi all,
> 
> Benjamin Herrenschmidt and I are proud to announce the first release of 
> petitboot - a graphical bootloader for the PS3, based on twin and 
> kboot.

.../...

Due to a bug in the make dist scripts, the TODO and COPYING files are
missing from the archive (oops ... it's really all GPL).

Until we make a fixed release, you can get the full thing via git at

	git://git.infradead.org/petitboot.git

Or take a peek with

	http://git.infradead.org/?p=petitboot.git;a=summary

Cheers,
Ben.
