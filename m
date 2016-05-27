Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rGQm91vn9zDqbk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 22:48:08 +1000 (AEST)
Received: from localhost
 by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Fri, 27 May 2016 13:48:06 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id E46912190046
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 13:47:37 +0100 (BST)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4RCm3DR10748174
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 12:48:04 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4RCm3Mr019125
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 06:48:03 -0600
Subject: Re: [PATCH] cxl: Abstract the differences between the PSL and XSL
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 mikey <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Huy Nguyen <huyn@mellanox.com>
References: <1464025158-23849-1-git-send-email-imunsie@au.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Message-ID: <57484202.1050603@linux.vnet.ibm.com>
Date: Fri, 27 May 2016 14:48:02 +0200
MIME-Version: 1.0
In-Reply-To: <1464025158-23849-1-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ian,

It looks good, just one question:

> +/* XSL registers (Mellanox CX4) */
> +static const cxl_p1_reg_t CXL_XSL_Timebase  = {0x0100};
> +static const cxl_p1_reg_t CXL_XSL_TB_CTLSTAT = {0x0108};
> +static const cxl_p1_reg_t CXL_XSL_FEC       = {0x0158};
> +static const cxl_p1_reg_t CXL_XSL_DSNCTL    = {0x0168};

Out of curiosity, in which document did you get those offsets from? I 
remember there used to be some confusion about it. All I could find was 
the internal offsets the firmware remaps those to (in xsl databook).

Feel free to grab the "From:", since the patch has evolved since I 
worked on it. I don't care.

   Fred
