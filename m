Return-Path: <olof@lixom.net>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3lrM3cHdzDqQn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 05:00:01 +1000 (AEST)
Received: by mail-wm0-x241.google.com with SMTP id q128so32461078wma.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Aug 2016 12:00:01 -0700 (PDT)
Date: Tue, 2 Aug 2016 11:54:47 -0700
From: Olof Johansson <olof@lixom.net>
To: Baole Ni <baolex.ni@intel.com>
Cc: mchehab@kernel.org, maurochehab@gmail.com, mchehab@infradead.org,
 mchehab@redhat.com, m.chehab@samsung.com, egor@pasemi.com,
 dougthompson@xmission.com, bp@alien8.de,
 linuxppc-dev@lists.ozlabs.org, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, chuansheng.liu@intel.com,
 lee.jones@linaro.org
Subject: Re: [PATCH 0157/1285] Replace numeric parameter like 0444 with macro
Message-ID: <20160802185447.GA5288@localhost>
References: <20160802104515.24206-1-baolex.ni@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160802104515.24206-1-baolex.ni@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 02, 2016 at 06:45:15PM +0800, Baole Ni wrote:
> I find that the developers often just specified the numeric value
> when calling a macro which is defined with a parameter for access permission.
> As we know, these numeric value for access permission have had the corresponding macro,
> and that using macro can improve the robustness and readability of the code,
> thus, I suggest replacing the numeric parameter with the macro.

Am I the only one who find the readability to be MUCH better for the
numeric values?


-Olof
