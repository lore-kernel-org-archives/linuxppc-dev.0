Return-Path: <jwboyer@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D6C221007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jul 2011 22:35:39 +1000 (EST)
Received: by vws20 with SMTP id 20so3814533vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jul 2011 05:35:33 -0700 (PDT)
MIME-Version: 1.0
Sender: jwboyer@gmail.com
In-Reply-To: <20110705044419.GA20597@ozlabs.org>
References: <20110705044419.GA20597@ozlabs.org>
Date: Tue, 12 Jul 2011 08:35:33 -0400
Message-ID: <CA+5PVA7fz9Y=3K=3z2q9x78jCt14umwNtXiRVjFarKLxdxWf6A@mail.gmail.com>
Subject: Re: [PATCH] mm: Fix output of total_ram.
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 5, 2011 at 12:44 AM, Tony Breeds <tony@bakeyournoodle.com> wrot=
e:
> On 32bit platforms that support >=3D 4GB memory total_ram was truncated.
> This creates a confusing printk:
> =A0 =A0 =A0 =A0Top of RAM: 0x100000000, Total RAM: 0x0
> Fix that:
> =A0 =A0 =A0 =A0Top of RAM: 0x100000000, Total RAM: 0x100000000
>
> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
