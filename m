Return-Path: <albert_herranz@yahoo.es>
Received: from smtp120.mail.ukl.yahoo.com (smtp120.mail.ukl.yahoo.com
	[77.238.184.51]) by ozlabs.org (Postfix) with SMTP id 5C165B7DA9
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Mar 2010 17:17:49 +1100 (EST)
Message-ID: <4B9F228A.8030005@yahoo.es>
Date: Tue, 16 Mar 2010 07:17:46 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [PATCH v4 04/11] swiotlb: support NOT_COHERENT_CACHE PowerPC
	platforms
References: <1268421166-4791-1-git-send-email-albert_herranz@yahoo.es>	<1268421166-4791-5-git-send-email-albert_herranz@yahoo.es>	<20100316105423B.fujita.tomonori@lab.ntt.co.jp>
	<20100316112444D.fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20100316112444D.fujita.tomonori@lab.ntt.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Cc: x86@kernel.org, linux-ia64@vger.kernel.org, linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

FUJITA Tomonori wrote:
> If we want to make swiotlb generic (make on any architectures), we
> need to handle more cache issues here, I think. So it's better to have
> more generic ways instead of adding hooks to some archs.
> 

Ok. So what would be an acceptable way of handling this in a generic way?
Should we for example have 2 levels of DMA ops in the swiotlb case (swiotlb and "actual") and call the 2nd level ("actual") from the swiotlb code whenever we need to act on non-bounced buffers?
Any other ideas?

Thanks,
Albert
