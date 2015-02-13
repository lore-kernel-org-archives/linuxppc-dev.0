Return-Path: <rpixley@graphitesystems.com>
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9D29E1A0BCF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Feb 2015 04:41:11 +1100 (AEDT)
Received: by mail-pa0-f48.google.com with SMTP id eu11so20235516pac.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 09:41:09 -0800 (PST)
From: K Richard Pixley <rpixley@graphitesystems.com>
Subject: embedding dtb file into kernel
To: linuxppc-dev@lists.ozlabs.org
message-id: <54DE3732.2080707@graphitesystems.com>
Date: Fri, 13 Feb 2015 09:41:06 -0800
mime-version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm having trouble figuring out how to embed a dtb file into my kernel.  I'm thinking that there should be a standard, architecture independent facility for this akin to initramfs, yes?

Could someone please either point me to the standard facility, relevant doc, a currently building board that uses the standard facility, or outline what needs to be done to do this with a new board?

If it matters, (I can't think why it would), I'm working with powerpc on a 3.10 kernel.  But if there are better facilities in other versions I'd appreciate hearing about that too.

Thank you in advance.

--rich
