Return-Path: <ppc6dev@digitaldans.com>
Received: from digitaldans.com (digitaldans.com [69.36.177.99])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 19A43B6F64
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Oct 2011 12:08:48 +1100 (EST)
Message-Id: <A1820550-38CB-445E-B7EB-7D0077673686@digitaldans.com>
From: Dan Malek <ppc6dev@digitaldans.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <OF76F1F5B7.8750C8C4-ONC1257927.00767D9A-C1257927.0076B5BE@transmode.se>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH 0/3] 8xx: Large page(8MB) support for 2.4
Date: Wed, 12 Oct 2011 18:08:12 -0700
References: <1318246714-5015-1-git-send-email-Joakim.Tjernlund@transmode.se>
 <39B024CE-70A2-4D32-A29C-5702C7D2D6CF@digitaldans.com>
 <OFAF68F93F.57D058F1-ONC1257925.005B7C6F-C1257925.005C10D7@transmode.se>
 <9CE82FAD-2451-4253-B304-CF8BE5AC8CAC@digitaldans.com>
 <OF5A487DD5.BE515A85-ONC1257926.0029F008-C1257926.002A6323@LocalDomain>
 <OF76F1F5B7.8750C8C4-ONC1257927.00767D9A-C1257927.0076B5BE@transmode.se>
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Willy Tarreau <w@1wt.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Joakim.

On Oct 12, 2011, at 2:36 PM, Joakim Tjernlund wrote:

> Dan, where did you go? I figured you would throw yourself at this as  
> this is
> something you been meaning to do yourself for years :)

Too many things to do :-)  I did have the wired page version that I've
been using now and then.

I had the bad thought yesterday that we need to check the
implementation for coherent memory.  It appears we set the
pages non-cached, which could cause some trouble.  We
have to ensure we never access the same physical page
with different attributes from the 8M mapping and the single
page "coherent" mapping.

I'll try to get some testing done.

Thanks.

	-- Dan
