Return-Path: <jesse.brandeburg@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.228])
	by ozlabs.org (Postfix) with ESMTP id 263BADE3C8
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 03:22:17 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so58949rvb.9
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 09:22:16 -0700 (PDT)
Message-ID: <4807377b0810160922q70fdcc95u36d937f29c473f14@mail.gmail.com>
Date: Thu, 16 Oct 2008 09:22:15 -0700
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "David Miller" <davem@davemloft.net>,
	"Jeff Kirsher" <jeffrey.t.kirsher@intel.com>
Subject: Re: powerpc allmodconfig
In-Reply-To: <20081015.235844.206136521.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20081015.220247.262683261.davem@davemloft.net>
	<1224137292.26782.5.camel@dwillia2-linux.ch.intel.com>
	<48F6E54C.5010207@myri.com>
	<20081015.235844.206136521.davem@davemloft.net>
Cc: bzolnier@gmail.com, marek.vasut@gmail.com, tiwai@suse.de,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	mark.fasheh@oracle.com, linuxppc-dev@ozlabs.org,
	linux-ide@vger.kernel.org, brice@myri.com,
	jesse.brandeburg@intel.com, dan.j.williams@intel.com,
	linux-ext4@vger.kernel.org, dwmw2@infradead.org,
	akpm@linux-foundation.org, mchehab@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 15, 2008 at 11:58 PM, David Miller <davem@davemloft.net> wrote:
>> There's already a completely different fix queued in netdev patchworks
>> (for myri10ge only right now, to be duplicated for Intel drivers). The
>> idea is to stop having almost-unrelated drivers select each other
>> directly, let people select which drivers they really want, and have
>> Kconfig handle modules/builtin-stuff correctly. See
>> http://patchwork.ozlabs.org/patch/4506/
>
> Right, my plan was to duplicate this for the other drivers.

The work is already done for ixgbe and igb, and we have it in testing.
 It should be in your inbox today or tomorrow.
