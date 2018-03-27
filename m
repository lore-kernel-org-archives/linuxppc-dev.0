Return-Path: <groeck7@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409Rzy1gy9zF2BL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 21:28:13 +1100 (AEDT)
Received: by mail-pl0-x243.google.com with SMTP id b7-v6so13820894plr.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 03:28:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH script] hwmon: Use octal not symbolic permissions
To: Joe Perches <joe@perches.com>, Jean Delvare <jdelvare@suse.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 patches@opensource.cirrus.com
References: <1522096136.12357.21.camel@perches.com>
 <9b112651-d0cf-5f3b-b643-3328028a95cd@roeck-us.net>
 <1522136107.12357.58.camel@perches.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5ec8703b-2979-7a1d-fbc3-bd528d7a5e29@roeck-us.net>
Date: Tue, 27 Mar 2018 03:28:10 -0700
MIME-Version: 1.0
In-Reply-To: <1522136107.12357.58.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/27/2018 12:35 AM, Joe Perches wrote:
> On Mon, 2018-03-26 at 23:33 -0700, Guenter Roeck wrote:
>> Since the hwmon subsystem has been labeled as both "obsolete" and "obscure",
> 
> fyi: It's marked Maintained in MAINTAINERS
> 

I did not say that it was not maintained, and I am aware of the information
in the MAINTAINERS file, thanks.

Guenter
