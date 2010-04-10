Return-Path: <bgat@billgatliff.com>
Received: from mail-yx0-f189.google.com (mail-yx0-f189.google.com
	[209.85.210.189]) by ozlabs.org (Postfix) with ESMTP id 00DBCB7D17
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Apr 2010 13:57:56 +1000 (EST)
Received: by yxe27 with SMTP id 27so2060782yxe.17
	for <linuxppc-dev@ozlabs.org>; Fri, 09 Apr 2010 20:57:54 -0700 (PDT)
Message-ID: <4BBFF789.3030201@billgatliff.com>
Date: Fri, 09 Apr 2010 22:59:05 -0500
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	linux-embedded <linux-embedded@vger.kernel.org>
Subject: Re: A better way to sequence driver initialization?
References: <4BBF7E9C.80604@billgatliff.com> <4BBFF66D.7020206@billgatliff.com>
In-Reply-To: <4BBFF66D.7020206@billgatliff.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bill Gatliff wrote:
> Maybe there are fewer places that would need wait queues than I
> originally thought!  At least for drivers that use the device API,
> kset_find_obj() might be the only place that needs to wait until a
> device or bus appears.

... and kset_register() might be the only place that calls
wake_up_interruptible().  Wow.


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com
