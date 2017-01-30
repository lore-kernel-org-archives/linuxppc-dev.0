Return-Path: <robherring2@gmail.com>
Received: from mail-ot0-f194.google.com (mail-ot0-f194.google.com
 [74.125.82.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBxjx07hmzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 04:49:56 +1100 (AEDT)
Received: by mail-ot0-f194.google.com with SMTP id 65so39137695otq.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 09:49:56 -0800 (PST)
Date: Mon, 30 Jan 2017 11:49:53 -0600
From: Rob Herring <robh@kernel.org>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v6 5/5] Documentation:powerpc: Add device-tree bindings
 for power-mgt
Message-ID: <20170130174953.j3mcr2qlmh3fbznb@rob-hp-laptop>
References: <1485333389-5752-1-git-send-email-ego@linux.vnet.ibm.com>
 <1485333389-5752-6-git-send-email-ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1485333389-5752-6-git-send-email-ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 25, 2017 at 02:06:29PM +0530, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Document the device-tree bindings defining the the properties under
> the @power-mgt node in the device tree that describe the idle states
> for Linux running on baremetal POWER servers.
> 
> These bindings are documented separately instead of using the the
> common idle state bindings since the idle-states on POWER servers
> are exposed as property arrays where as the common idle state bindings
> expect idle-states to be described as nodes.
> 
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  .../devicetree/bindings/powerpc/opal/power-mgt.txt | 118 +++++++++++++++++++++
>  1 file changed, 118 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/powerpc/opal/power-mgt.txt

Acked-by: Rob Herring <robh@kernel.org>
