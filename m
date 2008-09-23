Return-Path: <scottwood@freescale.com>
Date: Tue, 23 Sep 2008 13:50:32 -0500
From: Scott Wood <scottwood@freescale.com>
To: VenkataKrishna <venkatakrishnap@vrindatech.com>
Subject: Re: HRCW on MPC8260
Message-ID: <20080923185032.GC9984@ld0162-tx32.am.freescale.net>
References: <20080919121704.7AF08DDF63@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080919121704.7AF08DDF63@ozlabs.org>
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Sep 19, 2008 at 05:42:12PM +0530, VenkataKrishna wrote:
> I am working ELDK Kit 4.0 versions in Linux. My target Board is MPC8260
> processor. I generated linux uImage with linux-2.6-denx and is it need hard
> reset configuration words in linux. I don't find HRCW (Hard reset
> configuration word) anywhere in linux. In My target Board we are using Five
> memory device (SRAM, SRAM, Flash) and where can I instalization these memory
> in linux.

The HRCW is generally provided by firmware (U-boot or similar), not the
kernel.  You cannot boot directly into Linux.

-Scott
