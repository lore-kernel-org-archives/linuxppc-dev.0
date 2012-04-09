Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7CFA7B700C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2012 07:38:06 +1000 (EST)
Message-ID: <1334007463.3040.43.camel@pasglop>
Subject: Re: Problem with framebuffer mmap on platforms with large addressing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Date: Tue, 10 Apr 2012 07:37:43 +1000
In-Reply-To: <CALT56yOU2FDTNRnr=aLVFTGHiVsGNKVoqLqAWQ7Q+Xzg6_B8qQ@mail.gmail.com>
References: <CALT56yO05UBY6=KqK94=_sC4hd3ranj5J5CXOAo5hSjVAdkgkA@mail.gmail.com>
 <1332031585.3105.197.camel@pasglop>
 <CALT56yOaxfWYwxvBDbo9dpWo9y37dO0iGge4x6kciZp1oXXHVw@mail.gmail.com>
 <1332103797.3105.202.camel@pasglop>
 <CALT56yPjkPQOaXW4Eg8c-S4+a4Omou_YYacqrsCoTAYeXO0XkA@mail.gmail.com>
 <1332222008.2982.13.camel@pasglop>
 <CALT56yOU2FDTNRnr=aLVFTGHiVsGNKVoqLqAWQ7Q+Xzg6_B8qQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-fbdev@vger.kernel.org,
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
 Tony Breeds <tbreeds@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-04-09 at 20:18 +0400, Dmitry Eremin-Solenikov wrote:
> > As for the patches, you'll have to wait for Tony to respond (I'll
> poke
> > him locally).
> 
> Any news on these patches? A dirty and "not for the upstream yet"
> version
> would be sufficient for me for now.

I'll poke again..

Cheers,
Ben.
