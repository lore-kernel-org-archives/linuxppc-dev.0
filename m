Return-Path: <cyrilbur@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xBLwG4JsGzDrFj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 10:42:22 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id d193so647039pgc.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 17:42:22 -0700 (PDT)
Message-ID: <1500338535.2475.4.camel@gmail.com>
Subject: Re: [PATCH v3 03/10] mtd: powernv_flash: Don't treat OPAL_SUCCESS
 as an error
From: Cyril Bur <cyrilbur@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-mtd@lists.infradead.org
Cc: stewart@linux.vnet.ibm.com, alistair@popple.id.au, dwmw2@infradead.org,
 rlippert@google.com
Date: Tue, 18 Jul 2017 10:42:15 +1000
In-Reply-To: <1500281422.8256.5.camel@gmail.com>
References: <20170712042304.19745-1-cyrilbur@gmail.com>
 <20170712042304.19745-4-cyrilbur@gmail.com>
 <1500281422.8256.5.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-07-17 at 18:50 +1000, Balbir Singh wrote:
> On Wed, 2017-07-12 at 14:22 +1000, Cyril Bur wrote:
> > While this driver expects to interact asynchronously, OPAL is well
> > within its rights to return OPAL_SUCCESS to indicate that the operation
> > completed without the need for a callback. We shouldn't treat
> > OPAL_SUCCESS as an error rather we should wrap up and return promptly to
> > the caller.
> > 
> > Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> > ---
> > I'll note here that currently no OPAL exists that will return
> > OPAL_SUCCESS so there isn't the possibility of a bug today.
> 
> It would help if you mentioned OPAL_SUCCESS to the async call. So effectively
> what we expected to be an asynchronous call with callback, but OPAL returned
> immediately with success.
> 

Ah my favourite problems, commit message.

Thanks,

Cyril

> Balbir Singh.
> 
