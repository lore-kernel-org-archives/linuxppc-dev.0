Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3m700P8xzDqQn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 05:12:43 +1000 (AEST)
Date: Tue, 2 Aug 2016 14:11:30 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
Cc: Baole Ni <baolex.ni@intel.com>, chuansheng.liu@intel.com,
 maurochehab@gmail.com, mchehab@redhat.com, linux-edac@vger.kernel.org,
 lee.jones@linaro.org, linux-kernel@vger.kernel.org,
 mchehab@infradead.org, egor@pasemi.com, dougthompson@xmission.com,
 bp@alien8.de, mchehab@kernel.org, linuxppc-dev@lists.ozlabs.org,
 m.chehab@samsung.com
Subject: Re: [PATCH 0157/1285] Replace numeric parameter like 0444 with macro
Message-ID: <20160802191130.GG9387@gate.crashing.org>
References: <20160802104515.24206-1-baolex.ni@intel.com>
 <20160802185447.GA5288@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160802185447.GA5288@localhost>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 02, 2016 at 11:54:47AM -0700, Olof Johansson wrote:
> On Tue, Aug 02, 2016 at 06:45:15PM +0800, Baole Ni wrote:
> > I find that the developers often just specified the numeric value
> > when calling a macro which is defined with a parameter for access permission.
> > As we know, these numeric value for access permission have had the corresponding macro,
> > and that using macro can improve the robustness and readability of the code,
> > thus, I suggest replacing the numeric parameter with the macro.
> 
> Am I the only one who find the readability to be MUCH better for the
> numeric values?

You are not the only one.  Robustness is a non-issue here as well (except
that this patch series showed that some mail servers struggle to handle
1285 emails).


Segher
