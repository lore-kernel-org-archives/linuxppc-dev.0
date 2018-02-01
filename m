Return-Path: <SRS0=M4tJ=E3=goodmis.org=rostedt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zXRSr1kNvzF0TR
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Feb 2018 04:10:20 +1100 (AEDT)
Date: Thu, 1 Feb 2018 12:10:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Frank Rowand <frowand.list@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, devicetree@vger.kernel.org, Tyrel
 Datwyler <tyreld@linux.vnet.ibm.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, linux-renesas-soc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Rob Herring <robh+dt@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/1] of: easier debugging for node life cycle issues
Message-ID: <20180201121015.72fd242c@gandalf.local.home>
In-Reply-To: <4b373579-7a86-6883-2624-12a5408bb49b@gmail.com>
References: <20180121143117.19805-1-wsa+renesas@sang-engineering.com>
 <00fc90ee-de26-f819-9c81-27d06918564d@gmail.com>
 <20180125060330.781667e9@vmware.local.home>
 <a30d4cd3-0068-8cca-cc2f-ca207d0d278b@gmail.com>
 <20180125231443.44yy65ztr6exaam7@ninjato>
 <4b373579-7a86-6883-2624-12a5408bb49b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 25 Jan 2018 16:46:06 -0800
Frank Rowand <frowand.list@gmail.com> wrote:

> The point is that using ftrace means there are use cases for the
> debug information where the information will not be available.

Note, this email came out when I was traveling. I'm now looking at the
code and trace events are enabled right after rcu_init() in init/main.c.

The early_initcall() enables syscall events(), as they are not
available earlier.

-- Steve
