Return-Path: <vz@mleia.com>
Received: from mail.mleia.com (li271-223.members.linode.com [178.79.152.223])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 96E091A0021
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Aug 2015 22:51:59 +1000 (AEST)
Message-ID: <55C5FB6A.5010300@mleia.com>
Date: Sat, 08 Aug 2015 15:51:54 +0300
From: Vladimir Zapolskiy <vz@mleia.com>
MIME-Version: 1.0
To: Wolfram Sang <wsa@the-dreams.de>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Jean Delvare <jdelvare@suse.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] misc: remove boundary checks from bin attr users
References: <1437945502-27944-1-git-send-email-vz@mleia.com>
 <20150807161055.GD25357@katana> <55C4D9B2.3000708@mleia.com>
 <20150807223456.GA1527@katana>
In-Reply-To: <20150807223456.GA1527@katana>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wolfram,

On 08.08.2015 01:34, Wolfram Sang wrote:
> 
>> if we're talking about this particular series, you should have them in
>> your mailbox, since you have them applied in wsa/i2c/for-next:
> 
> Those are already in linus tree. I mean all drivers which use struct
> i2c_driver. Or do you prefer they go via Greg? I am fine with both.
> 

I think you may find most of the changes applied by Greg into
misc/char-misc-next branch.

The only change from the series, which is not found in
misc/char-misc-next or i2c/for-next is related to at25 driver (IC is
sitting on SPI):

  https://lkml.org/lkml/2015/7/26/101

Change 8/8 for sunxi is outdated due to accepted NVMEM framework.

With best wishes,
Vladimir
