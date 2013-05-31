Return-Path: <sebastian.hesselbarth@gmail.com>
Received: from mail-wg0-x22f.google.com (mail-wg0-x22f.google.com
 [IPv6:2a00:1450:400c:c00::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 769262C0089
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2013 16:29:07 +1000 (EST)
Received: by mail-wg0-f47.google.com with SMTP id e11so909766wgh.14
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 23:29:03 -0700 (PDT)
Message-ID: <51A8432A.4000602@gmail.com>
Date: Fri, 31 May 2013 08:28:58 +0200
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v5 00/13] net: mv643xx_eth DT support and fixes
References: <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369855975-21489-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130530.175549.407800685811475192.davem@davemloft.net>
In-Reply-To: <20130530.175549.407800685811475192.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: andrew@lunn.ch, jason@lakedaemon.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, buytenh@wantstofly.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/31/2013 02:55 AM, David Miller wrote:
> From: Sebastian Hesselbarth<sebastian.hesselbarth@gmail.com>
> Date: Wed, 29 May 2013 21:32:42 +0200
>
>> For the patches above I suggest to take Patches 1-6 through David
>> Miller's branch, and Patches 7-12 through Jason Cooper's when the
>> former have appeared on mainline linux. The patch set has been based
>> on v3.10-rc3.
>
> Patches 1-6 applied to net-next, and patch #1 queued up for -stable.

David,

thanks for pulling these in. I finally found how to check if a patch
already went into -stable. As Jason already said, the mdio patch that
#1 fixes did not yet went into -stable. Can you unqueue it? Sorry for
the confusion.

Sebastian
