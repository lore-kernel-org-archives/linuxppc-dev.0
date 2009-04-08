Return-Path: <timur.tabi@gmail.com>
Received: from mail-qy0-f110.google.com (mail-qy0-f110.google.com
	[209.85.221.110]) by ozlabs.org (Postfix) with ESMTP id 786D3DE088
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2009 08:15:48 +1000 (EST)
Received: by qyk8 with SMTP id 8so677684qyk.17
	for <linuxppc-dev@ozlabs.org>; Wed, 08 Apr 2009 15:15:46 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <49DD17C3.7040607@kernel.org>
References: <49DB6914.1030107@freescale.com> <49DBE858.9040004@kernel.org>
	<ed82fe3e0904071736w55dff582y8ac2681f6410865b@mail.gmail.com>
	<1239156559.10104.7.camel@localhost>
	<ed82fe3e0904080440w130b5dc5of6d5ed3051ed04e2@mail.gmail.com>
	<49DD1154.3040106@kernel.org> <49DD11D1.7060105@freescale.com>
	<49DD1375.8030400@kernel.org> <49DD1465.6070001@freescale.com>
	<49DD17C3.7040607@kernel.org>
Date: Wed, 8 Apr 2009 17:15:46 -0500
Message-ID: <ed82fe3e0904081515k6e53de00g7d5256f9b61a03da@mail.gmail.com>
Subject: Re: "ahci: drop intx manipulation on msi enable" breaks ULI M1575
From: Timur Tabi <timur@freescale.com>
To: Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
	Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 8, 2009 at 4:31 PM, Tejun Heo <tj@kernel.org> wrote:
> Hmmm... for now,
> I think it would be best to revert the original change. =A0Jeff, can you
> please do that?

Actually, give me a few days before you do that.  A colleague gave me
some suggestions to debug this.

--=20
Timur Tabi
Linux kernel developer at Freescale
