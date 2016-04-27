Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvspX190XzDqB2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 18:00:52 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id p185so4314393pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 01:00:52 -0700 (PDT)
Subject: Re: [PATCH V2 1/2] devicetree/bindings: Add binding for operator
 panel on FSP machines
To: Stewart Smith <stewart@linux.vnet.ibm.com>
References: <1460423107-7270-1-git-send-email-sjitindarsingh@gmail.com>
 <87mvofiqxr.fsf@linux.vnet.ibm.com>
Cc: arnd@arndb.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 paulus@samba.org, andrew.donnellan@au1.ibm.com, linuxppc-dev@lists.ozlabs.org
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <572071AB.1010307@gmail.com>
Date: Wed, 27 Apr 2016 18:00:43 +1000
MIME-Version: 1.0
In-Reply-To: <87mvofiqxr.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27/04/16 15:03, Stewart Smith wrote:
> Suraj Jitindar Singh <sjitindarsingh@gmail.com> writes:
>> Add a binding to Documentation/devicetree/bindings/powerpc/opal
>> (oppanel-opal.txt) for the operator panel which is present on IBM
>> pseries machines with FSPs.
> It's not pseries (as that implies PowerVM / PAPR) - while here we're all
> about OPAL.

Thanks, will fix that up.

> With a slight change to the commit message,
> Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>
>
>
