Return-Path: <tony@bakeyournoodle.com>
Date: Tue, 11 Dec 2007 09:01:51 +1100
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: ppc vs powerpc
Message-ID: <20071210220151.GC24243@bakeyournoodle.com>
References: <9e4733910712101254r1bf8925o20ee6eacd3af6a18@mail.gmail.com>
	<fa686aa40712101259h22be4b89ke4f36564a7c1866c@mail.gmail.com>
	<9e4733910712101354i31020c2w72d74bf33ba3e90b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <9e4733910712101354i31020c2w72d74bf33ba3e90b@mail.gmail.com>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 10, 2007 at 04:54:32PM -0500, Jon Smirl wrote:
 
> How can I tell a build for ARCH=ppc vs ARCH=powerpc in Kconfig?

IIRC ARCH=powerpc will have CONFIG_PPC_MERGE set, arch=ppc will not.

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
