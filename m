Return-Path: <timur.tabi@gmail.com>
Received: from mail-qy0-f110.google.com (mail-qy0-f110.google.com
	[209.85.221.110]) by ozlabs.org (Postfix) with ESMTP id 94946DDF2A
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 21:40:51 +1000 (EST)
Received: by qyk8 with SMTP id 8so91129qyk.17
	for <linuxppc-dev@ozlabs.org>; Wed, 08 Apr 2009 04:40:50 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <1239156559.10104.7.camel@localhost>
References: <49DB6914.1030107@freescale.com> <49DBE858.9040004@kernel.org>
	<ed82fe3e0904071736w55dff582y8ac2681f6410865b@mail.gmail.com>
	<1239156559.10104.7.camel@localhost>
Date: Wed, 8 Apr 2009 06:40:49 -0500
Message-ID: <ed82fe3e0904080440w130b5dc5of6d5ed3051ed04e2@mail.gmail.com>
Subject: Re: "ahci: drop intx manipulation on msi enable" breaks ULI M1575
From: Timur Tabi <timur@freescale.com>
To: michael@ellerman.id.au
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
	Jeff Garzik <jeff@garzik.org>,
	Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 7, 2009 at 9:09 PM, Michael Ellerman <michael@ellerman.id.au> wrote:

> Have you confirmed that INTX is disabled before that call?

How do I do that?

-- 
Timur Tabi
Linux kernel developer at Freescale
