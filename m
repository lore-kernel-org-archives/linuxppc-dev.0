Return-Path: <timur@freescale.com>
Message-ID: <4755FEA0.1050005@freescale.com>
Date: Tue, 04 Dec 2007 19:28:00 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Fix Firmware class name collision
References: <4755E6AC.9020808@freescale.com> <4755E835.6070704@freescale.com>
In-Reply-To: <4755E835.6070704@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Markus Rechberger <markus.rechberger@amd.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:

> The physical address certainly is useful when you have more than one 
> device of the same name.

What I meant was that the physical address isn't helpful by itself.

> So then you'd get "firmware-ucc.e01024".  What if there's another ucc at 
>  e0102480?  For devices with longer names, you'd have even less 
> precision in the address.

Maybe we need to consider a more sophisticated algorithm, one that guarantees 
that the device name in its entirety is preserved?  Either that, or replace 
the physical address with something shorter, like the offset to the root node 
only?  That way, ucc.e0102400 because just ucc.2400.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
