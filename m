Return-Path: <geoff@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yhqVk59HczDqws
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 04:40:45 +1100 (AEDT)
Subject: Boot new kernel on PS3
To: Kevin Yeske <Modournation@live.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <CO2PR04MB22627F6185164FB2FB160969BE230@CO2PR04MB2262.namprd04.prod.outlook.com>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <8720ea07-5251-fd57-d726-0e2b03b51cc5@infradead.org>
Date: Wed, 22 Nov 2017 09:40:34 -0800
MIME-Version: 1.0
In-Reply-To: <CO2PR04MB22627F6185164FB2FB160969BE230@CO2PR04MB2262.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 11/21/2017 12:41 PM, Kevin Yeske wrote:
> I have been working on trying to get a newer kernel and Ubuntu version running on the PS3 within otherOS on a PS3 slim.

There was a breakage in the kernel ABI, and the old petitboot
bootloader (ps3-petitboot-09.11.30) cannot boot kernels newer
than v3.15.

If you want to boot a newer kernel you would need to write
the new kernel into flash memory.  If you have a fat model
with firmware 3.15 or lower, do this with  with ps3-flash-util.
Since you have a slim, you'll need to ask for help in the
hacker community.

If you want to try a new kernel I recommend you start with the
latest petitboot-dev branch (currently petitboot-dev-v4.13) from
my ps3-linux repo:

  https://git.kernel.org/pub/scm/linux/kernel/git/geoff/ps3-linux.git

Use the ps3_petitboot_nfs_defconfig as a start.

I've been working on an updated petitboot, but that will only work
with fat models with firmware 3.15 or lower.

-Geoff
