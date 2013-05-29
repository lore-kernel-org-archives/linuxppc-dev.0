Return-Path: <timur@tabi.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 717DB2C0347
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 May 2013 12:37:08 +1000 (EST)
Message-ID: <51A569CE.6010100@tabi.org>
Date: Tue, 28 May 2013 21:37:02 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Libo Chen <clbchenlibo.chen@huawei.com>,
 Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] driver: tty: add missing unregister in err case
References: <51A568EC.2070103@huawei.com>
In-Reply-To: <51A568EC.2070103@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: jslaby@suse.cz, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>, Li Zefan <lizefan@huawei.com>,
 linux-serial@vger.kernel.org, Grant Likely <grant.likely@linaro.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Libo Chen wrote:
> when platform_driver_register broken, we should unregister ucc_uart_driver
>
> Signed-off-by: Libo chen<libo.chen@huawei.com>

Acked-by: Timur Tabi <timur@tabi.org>

Thanks for catching this.

-- 
Timur Tabi
