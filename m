Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qkpFy72bJzDq5m
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 23:49:42 +1000 (AEST)
Date: Tue, 12 Apr 2016 08:49:36 -0500
From: Rob Herring <robh@kernel.org>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: Re: [PATCH 1/2] devicetree/bindings: Add binding for operator panel
 on FSP machines
Message-ID: <20160412134936.GA3700@rob-hp-laptop>
References: <1460338890-19693-1-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460338890-19693-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 11, 2016 at 11:41:29AM +1000, Suraj Jitindar Singh wrote:
> Add a binding to Documentation/devicetree/bindings/powerpc/opal
> (oppanel-opal.txt) for the operator panel which is present on IBM
> pseries machines with FSPs.
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> ---
>  .../devicetree/bindings/powerpc/opal/oppanel-opal.txt      | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/powerpc/opal/oppanel-opal.txt

Acked-by: Rob Herring <robh@kernel.org>
