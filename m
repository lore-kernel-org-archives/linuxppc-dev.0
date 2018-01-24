Return-Path: <public@hansmi.ch>
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zR7YD1xhLzDqJ6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jan 2018 12:55:42 +1100 (AEDT)
Received: by mail-wm0-x244.google.com with SMTP id r71so5463009wmd.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 17:55:42 -0800 (PST)
Sender: Michael Hanselmann <hansmi@hansmi.ch>
Reply-To: public@hansmi.ch
Subject: Re: [PATCH] macintosh/ams-input: Use true and false for boolean values
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Michael Hanselmann <linux-kernel@hansmi.ch>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gustavo A. R. Silva" <garsilva@embeddedor.com>
References: <20180124014846.GA27664@embeddedgus>
From: Michael Hanselmann <public@hansmi.ch>
Message-ID: <cd51fc7b-de66-e85d-00da-e506e812a460@msgid.hansmi.ch>
Date: Wed, 24 Jan 2018 02:55:39 +0100
MIME-Version: 1.0
In-Reply-To: <20180124014846.GA27664@embeddedgus>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 24.01.2018 02:48, Gustavo A. R. Silva wrote:
> Assign true or false to boolean variables instead of an integer value.
> 
> This issue was detected with the help of Coccinelle
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Michael Hanselmann <public@hansmi.ch>
