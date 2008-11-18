Return-Path: <timur.tabi@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id B3F61DDE0A
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 15:42:48 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id d11so1124395and.39
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Nov 2008 20:42:46 -0800 (PST)
Message-ID: <ed82fe3e0811172042r1d4887f8n76682e0b21555372@mail.gmail.com>
Date: Mon, 17 Nov 2008 22:42:46 -0600
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: "Timur Tabi" <timur@freescale.com>, "Paul Mackerras" <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
Subject: Re: powerpc: udbg based backend for hvc_console
In-Reply-To: <20081118004005.GC26336@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20081024035434.GF4267@yookeroo.seuss>
	<ed82fe3e0811171204y4e8de21dy18f5b332b7f05f1f@mail.gmail.com>
	<20081118004005.GC26336@yookeroo.seuss>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 17, 2008 at 6:40 PM, David Gibson
<david@gibson.dropbear.id.au> wrote:

> Because the udbg console works for kernel messages, but doesn't
> support a full tty interface, so you can't run userspace with only a
> udbg console.

I still don't understand the point of your driver.  You're just
routing hcalls to a udbg back-end.  So if you have a driver that
supports udbg but not standard console or TTY, then you can use your
driver to get console/tty I/O.  Is there a platform where such a setup
exists?  All HVC drivers support console and TTY, as do all serial
drivers.  So what platform would use your driver?

-- 
Timur Tabi
Linux kernel developer at Freescale
