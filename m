Return-Path: <sbabic@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 65DFE1A0728
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 00:50:34 +1100 (AEDT)
Message-ID: <54E0A2D7.8030700@denx.de>
Date: Sun, 15 Feb 2015 14:44:55 +0100
From: Stefano Babic <sbabic@denx.de>
MIME-Version: 1.0
To: K Richard Pixley <rpixley@graphitesystems.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: embedding dtb file into kernel
References: <54DE3732.2080707@graphitesystems.com>
In-Reply-To: <54DE3732.2080707@graphitesystems.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Richard,

On 13/02/2015 18:41, K Richard Pixley wrote:
> I'm having trouble figuring out how to embed a dtb file into my kernel. 
> I'm thinking that there should be a standard, architecture independent
> facility for this akin to initramfs, yes?
> 
> Could someone please either point me to the standard facility, relevant
> doc, a currently building board that uses the standard facility, or
> outline what needs to be done to do this with a new board?
> 
> If it matters, (I can't think why it would), I'm working with powerpc on
> a 3.10 kernel.  But if there are better facilities in other versions I'd
> appreciate hearing about that too.
> 

Maybe it is worth to take a look at the fitImage, which can embed pretty
much anything (including DTB).

Best regards,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
