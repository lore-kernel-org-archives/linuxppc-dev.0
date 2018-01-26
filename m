Return-Path: <frowand.list@gmail.com>
Received: from mail-pg0-x22f.google.com (mail-pg0-x22f.google.com
 [IPv6:2607:f8b0:400e:c05::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zSKw26n6mzF0R5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jan 2018 11:46:10 +1100 (AEDT)
Received: by mail-pg0-x22f.google.com with SMTP id s9so6167606pgq.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jan 2018 16:46:10 -0800 (PST)
Subject: Re: [RFC PATCH v2 0/1] of: easier debugging for node life cycle issues
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Steven Rostedt <rostedt@goodmis.org>, devicetree@vger.kernel.org,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-renesas-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
References: <20180121143117.19805-1-wsa+renesas@sang-engineering.com>
 <00fc90ee-de26-f819-9c81-27d06918564d@gmail.com>
 <20180125060330.781667e9@vmware.local.home>
 <a30d4cd3-0068-8cca-cc2f-ca207d0d278b@gmail.com>
 <20180125231443.44yy65ztr6exaam7@ninjato>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <4b373579-7a86-6883-2624-12a5408bb49b@gmail.com>
Date: Thu, 25 Jan 2018 16:46:06 -0800
MIME-Version: 1.0
In-Reply-To: <20180125231443.44yy65ztr6exaam7@ninjato>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/25/18 15:14, Wolfram Sang wrote:
> 
>> This means that ftrace can not be used for the of_node_get(),
>> of_node_put(), and of_node_release() debug info, because
>> these functions are called before early_initcall().
> 
> For the record: You can still unbind/bind devices. This is how I
> debugged an issue.

I wasn't implying that the data wasn't usable for any use case.

The point is that using ftrace means there are use cases for the
debug information where the information will not be available.
