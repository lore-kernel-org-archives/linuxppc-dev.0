Return-Path: <sergei.shtylyov@cogentembedded.com>
Received: from mail-la0-f42.google.com (mail-la0-f42.google.com
 [209.85.215.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6D68A1A0839
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 07:48:32 +1000 (EST)
Received: by mail-la0-f42.google.com with SMTP id el20so2042790lab.29
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 14:48:27 -0700 (PDT)
Message-ID: <537D1F2F.6050100@cogentembedded.com>
Date: Thu, 22 May 2014 01:48:31 +0400
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
To: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH RESEND net-next 1/9] Documentation: devicetree: add old
 and deprecated 'fixed-link'
References: <1400708331-18088-1-git-send-email-f.fainelli@gmail.com>
 <1400708331-18088-2-git-send-email-f.fainelli@gmail.com>
In-Reply-To: <1400708331-18088-2-git-send-email-f.fainelli@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>,
 Aida Mynzhasova <aida.mynzhasova@skitlab.ru>,
 Richard Cochran <richardcochran@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 Claudiu Manoil <claudiu.manoil@freescale.com>,
 Vitaly Bordug <vbordug@ru.mvista.com>, Grant Likely <grant.likely@linaro.org>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

On 05/22/2014 01:38 AM, Florian Fainelli wrote:

> Update the fixed-link Device Tree binding documentation to contain
> information about the old and deprecated 5-digit 'fixed-link' property.

> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>   Documentation/devicetree/bindings/net/fixed-link.txt | 12 ++++++++++++
>   1 file changed, 12 insertions(+)

> diff --git a/Documentation/devicetree/bindings/net/fixed-link.txt b/Documentation/devicetree/bindings/net/fixed-link.txt
> index e956de1be935..34a991eb213f 100644
> --- a/Documentation/devicetree/bindings/net/fixed-link.txt
> +++ b/Documentation/devicetree/bindings/net/fixed-link.txt
> @@ -18,6 +18,18 @@ properties:
>   * 'asym-pause' (boolean, optional), to indicate that asym_pause should
>     be enabled.
>
> +Old, deprecated 'fixed-link' binding:
> +
> +* A 'fixed-link' property in the EThernet MAC node, with 5 cells, of the

    s/EThernet/Ethernet/

> +  form <a b c d e> with the following accepted values:
> +  - a: emulated phy id, choose any but but unique to the all specified

    s/phy id/PHY ID/

> +    fixed-links, from 0 to 31
> +  - b: duplex configuration: 0 for half duplex, 1 for full duplex
> +  - c: link speed in Mbits/sec, accepted values are: 10, 100 and 1000
> +  - d: pause configuration: 0 for no pause, 1 for pause
> +  - e: asymetric pause configuration: 0 for no asymetric pause, 1 for asymetric

    Asymmetric.

WBR, Sergei
