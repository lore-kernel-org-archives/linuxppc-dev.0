Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlVvh3jLyzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 03:21:20 +1000 (AEST)
Date: Wed, 13 Apr 2016 12:21:14 -0500
From: Rob Herring <robh@kernel.org>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 andrew.donnellan@au1.ibm.com
Subject: Re: [PATCH V2 1/2] devicetree/bindings: Add binding for operator
 panel on FSP machines
Message-ID: <20160413172114.GA11661@rob-hp-laptop>
References: <1460423107-7270-1-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460423107-7270-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 12, 2016 at 11:05:06AM +1000, Suraj Jitindar Singh wrote:
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
