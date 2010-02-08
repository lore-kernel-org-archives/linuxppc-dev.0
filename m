Return-Path: <bsingharora@gmail.com>
Received: from mail-pz0-f195.google.com (mail-pz0-f195.google.com
	[209.85.222.195]) by ozlabs.org (Postfix) with ESMTP id 41171B7D0F
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  8 Feb 2010 22:07:38 +1100 (EST)
Received: by pzk33 with SMTP id 33so3483458pzk.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 08 Feb 2010 03:07:37 -0800 (PST)
MIME-Version: 1.0
Sender: bsingharora@gmail.com
In-Reply-To: <20100207235205.GI32246@kryten>
References: <20100207235205.GI32246@kryten>
Date: Mon, 8 Feb 2010 16:37:37 +0530
Message-ID: <661de9471002080307p48e0ff69v6318790eaff1c64c@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Quieten cede latency printk
From: Balbir Singh <balbir@linux.vnet.ibm.com>
To: Anton Blanchard <anton@samba.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, Gautham R Shenoy <ego@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 8, 2010 at 5:22 AM, Anton Blanchard <anton@samba.org> wrote:
>
> The cede latency stuff is relatively new and we don't need to complain about
> it not working on older firmware.
>
> Signed-off-by: Anton Blanchard <anton@samba.org>

Acked-by: Balbir Singh <balbir@linux.vnet.ibm.com>

Seems like a reasonable change. CC'ing Vaidy and Gautham to look even
more closely at the patch.

Balbir
