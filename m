Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A78151A000E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 14:36:46 +1000 (EST)
Message-ID: <1403671005.12870.0.camel@concordia>
Subject: Re: [PATCH powerpc] Fix parameter restoring issue in commit 752a6422f
From: Michael Ellerman <mpe@ellerman.id.au>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Date: Wed, 25 Jun 2014 14:36:45 +1000
In-Reply-To: <1403670058.5842.15.camel@ThinkPad-T5421.cn.ibm.com>
References: <1403668804.5842.11.camel@ThinkPad-T5421.cn.ibm.com>
 <1403670058.5842.15.camel@ThinkPad-T5421.cn.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 Anton Blanchard <anton@samba.org>, ulrich.weigand@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-06-25 at 12:20 +0800, Li Zhong wrote:
> DaYu just reminded me that Michael already had a patch removing all the
> related code. 
> 
> Please ignore this patch..

Thanks for tracking down what the actual problem was.

cheers
