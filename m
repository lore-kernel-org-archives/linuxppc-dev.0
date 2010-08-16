Return-Path: <micha@neli.hopto.org>
Received: from edu-smtp-01.edutel.nl (edu-smtp-01.edutel.nl [88.159.1.175])
	by ozlabs.org (Postfix) with ESMTP id 96A57B70A8
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Aug 2010 22:22:25 +1000 (EST)
Message-ID: <4C692BBB.8090707@neli.hopto.org>
Date: Mon, 16 Aug 2010 14:14:51 +0200
From: Micha Nelissen <micha@neli.hopto.org>
MIME-Version: 1.0
To: Alexandre Bounine <alexandre.bounine@idt.com>
Subject: Re: [PATCH 3/9] RapidIO: Add the ingress port number into the RIO
	switch  data structure
References: <1281712686-31308-1-git-send-email-alexandre.bounine@idt.com>
	<1281712686-31308-4-git-send-email-alexandre.bounine@idt.com>
In-Reply-To: <1281712686-31308-4-git-send-email-alexandre.bounine@idt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexandre Bounine wrote:
> A switch ingress port number has to be saved for software assisted error
> recovery from the error-stopped state. Saving this information also allows
> to remove several register reads from the RIO enumeration process.

Why not keep using the swpinfo field, as you can extract it from there? 
And your code actually does this.

Also processor devices can have multiple ports (not only switches), it 
would be good to be ready for that use case.

Micha
