Return-Path: <kernelfans@gmail.com>
Received: from mail-it0-x233.google.com (mail-it0-x233.google.com
 [IPv6:2607:f8b0:4001:c0b::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKpG00kQSzDvss
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 17:37:44 +1100 (AEDT)
Received: by mail-it0-x233.google.com with SMTP id c20so14037712itb.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 22:37:43 -0800 (PST)
MIME-Version: 1.0
From: Liu ping fan <kernelfans@gmail.com>
Date: Fri, 18 Nov 2016 14:37:41 +0800
Message-ID: <CAFgQCTsUmYYSwNEJp=YD_FxVvGsW3G_69PdZxuGcF2P6JS-0vQ@mail.gmail.com>
Subject: fadump: a question about "ibm,configure-kernel-dump"
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I have an ibm-p8-garrison machine. But I can not find a node
"ibm,configure-kernel-dump" under /proc/device-tree.  Does garrison
machine support fadump? And normally, which component in open-power
presents the "ibm,configure-kernel-dump" ?  I had though it was in
skiboot gitree or  garrison-xml gitree, but found nothing.

Can anyone give a help?
Thx
