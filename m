Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t534L2SRQzDvTJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 23:30:09 +1100 (AEDT)
Date: Fri, 28 Oct 2016 08:30:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Mauro Carvalho Chehab <mchehab@infradead.org>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Matt Ranostay <mranostay@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] ABI: fix some syntax issues at the ABI database
Message-ID: <20161028123016.GA28642@kroah.com>
References: <cover.1477656806.git.mchehab@s-opensource.com>
 <d7e0af69cf14fe1cb9cf3298ea3fd98485a8de35.1477656806.git.mchehab@s-opensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d7e0af69cf14fe1cb9cf3298ea3fd98485a8de35.1477656806.git.mchehab@s-opensource.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 28, 2016 at 10:19:45AM -0200, Mauro Carvalho Chehab wrote:
> On those three files, the ABI representation described at
> README are violated.
> 
> - at sysfs-bus-iio-proximity-as3935:
> 	a ':' character is missing after "What"
> 
> - at sysfs-class-devfreq:
> 	there's a typo at Description
> 
> - at sysfs-class-cxl, it is using the ":" character at a
> 	file preamble, causing it to be misinterpreted as a
> 	tag.
> 
> - On the other files, instead of "What", they use "Where".
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
