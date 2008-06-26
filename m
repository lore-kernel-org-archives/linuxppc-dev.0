Return-Path: <monstr@seznam.cz>
Received: from mxl.seznam.cz (mxl.seznam.cz [77.75.72.44])
	by ozlabs.org (Postfix) with ESMTP id 3D92FDECE8
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 05:22:53 +1000 (EST)
Message-ID: <4863ECCE.2000407@seznam.cz>
Date: Thu, 26 Jun 2008 21:23:58 +0200
From: Michal Simek <monstr@seznam.cz>
MIME-Version: 1.0
To: Adrian Bunk <bunk@kernel.org>
Subject: Re: [PATCH 30/60] microblaze_v4: support for a.out
References: <1214483429-32360-22-git-send-email-monstr@seznam.cz>
	<1214483429-32360-23-git-send-email-monstr@seznam.cz>
	<1214483429-32360-24-git-send-email-monstr@seznam.cz>
	<1214483429-32360-25-git-send-email-monstr@seznam.cz>
	<1214483429-32360-26-git-send-email-monstr@seznam.cz>
	<1214483429-32360-27-git-send-email-monstr@seznam.cz>
	<1214483429-32360-28-git-send-email-monstr@seznam.cz>
	<1214483429-32360-29-git-send-email-monstr@seznam.cz>
	<1214483429-32360-30-git-send-email-monstr@seznam.cz>
	<1214483429-32360-31-git-send-email-monstr@seznam.cz>
	<20080626143713.GE30954@cs181140183.pp.htv.fi>
In-Reply-To: <20080626143713.GE30954@cs181140183.pp.htv.fi>
Content-Type: text/plain; charset=ISO-8859-2
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk, vapier.adi@gmail.com,
	arnd@arndb.de, matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	linux-kernel@vger.kernel.org, drepper@redhat.com,
	linuxppc-dev@ozlabs.org, will.newton@gmail.com, hpa@zytor.com,
	monstr@seznam.cz, John.Linn@xilinx.com, john.williams@petalogix.com
Reply-To: monstr@seznam.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Thu, Jun 26, 2008 at 02:29:59PM +0200, monstr@seznam.cz wrote:
>> From: Michal Simek <monstr@monstr.eu>
>>
>>
>> Signed-off-by: Michal Simek <monstr@monstr.eu>
>> ---
>>  0 files changed, 0 insertions(+), 0 deletions(-)
>>  create mode 100644 include/asm-microblaze/a.out.h
>>
>> diff --git a/include/asm-microblaze/a.out.h b/include/asm-microblaze/a.out.h
>> new file mode 100644
>> index 0000000..e69de29
> 
> As of 2.6.26-rc7 you do no longer need this header.
> 
> cu
> Adrian
I expect it but I haven't information about. I'll check it.

M
