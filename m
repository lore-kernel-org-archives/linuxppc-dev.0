Return-Path: <B04825@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
	[213.199.154.206])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6E1BDB6F76
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  9 Jul 2011 08:12:56 +1000 (EST)
Message-ID: <4E1780DA.3090800@freescale.com>
Date: Fri, 8 Jul 2011 17:12:42 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Subject: Re: tty/powerpc: introduce the ePAPR embedded hypervisor byte channel
	driver
References: <1305830092-20104-1-git-send-email-timur@freescale.com>
	<20110708220654.GA19146@kroah.com>
In-Reply-To: <20110708220654.GA19146@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: arnd@arndb.de, kumar.gala@freescale.com, linux-kernel@vger.kernel.org,
	akpm@kernel.org, linux-console@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greg KH wrote:
>> > 3) A tty driver, which is used to handle user-space input and output.  The
>> > byte channel used for the console is designated as the default tty.
>> > 
>> > Signed-off-by: Timur Tabi <timur@freescale.com>
> Doesn't apply at all to the tty-next tree, so I can't apply it here :(

I shall take care of that right now.

-- 
Timur Tabi
Linux kernel developer at Freescale
