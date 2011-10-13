Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 6D3C2B6F9F
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Oct 2011 02:34:30 +1100 (EST)
Message-ID: <4E9704F9.1090103@freescale.com>
Date: Thu, 13 Oct 2011 10:34:17 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH][v2] uio: Support 36-bit physical addresses on 32-bit
 systems
References: <1318453063-17349-1-git-send-email-galak@kernel.crashing.org>
 <CAOZdJXWd_u_EWXNhh3-t258+Y8mx=JuJhU93CeZfaocPZvhOFA@mail.gmail.com>
 <9BD33578-CD8E-4784-AC6A-ADE4614E0FC1@kernel.crashing.org>
In-Reply-To: <9BD33578-CD8E-4784-AC6A-ADE4614E0FC1@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "hjk@hansjkoch.de" <hjk@hansjkoch.de>, "gregkh@suse.de" <gregkh@suse.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jiang Kai-B18973 <B18973@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>>> >> +       phys_addr_t             addr;
>> > 
>> > Please add a comment here saying:
>> > 
>> > 1) That 'addr' can be a virtual or physical address
> The code and everything else makes that clear

I'm sorry, but I have to strongly disagree here.  It is *NOT* clear that a
variable of type 'phys_addr_t' can hold something that is not a physical address.

-- 
Timur Tabi
Linux kernel developer at Freescale
