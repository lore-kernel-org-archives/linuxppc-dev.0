Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8jLf5PW4zDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 06:24:58 +1000 (AEST)
Received: by mail-oi0-f66.google.com with SMTP id t127so4800599oie.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 13:24:58 -0700 (PDT)
Date: Wed, 10 Aug 2016 15:24:55 -0500
From: Rob Herring <robh@kernel.org>
To: Reza Arbab <arbab@linux.vnet.ibm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Jonathan Corbet <corbet@lwn.net>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: add doc for ibm,hotplug-aperture
Message-ID: <20160810202455.GA3468@rob-hp-laptop>
References: <1470680843-28702-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1470680843-28702-2-git-send-email-arbab@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470680843-28702-2-git-send-email-arbab@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 08, 2016 at 01:27:20PM -0500, Reza Arbab wrote:
> Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
> ---
>  .../bindings/powerpc/opal/hotplug-aperture.txt     | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/powerpc/opal/hotplug-aperture.txt

Acked-by: Rob Herring <robh@kernel.org>
