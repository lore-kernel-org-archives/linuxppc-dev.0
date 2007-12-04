Return-Path: <scottwood@freescale.com>
Message-ID: <4755E835.6070704@freescale.com>
Date: Tue, 04 Dec 2007 17:52:21 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: Fix Firmware class name collision
References: <4755E6AC.9020808@freescale.com>
In-Reply-To: <4755E6AC.9020808@freescale.com>
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

Timur Tabi wrote:
> 
> In other words, the only thing you get is the first letter of the device name. 
> You used to get the whole name.  The physical address obviously isn't very helpful.

The physical address certainly is useful when you have more than one 
device of the same name.

> Now, there are two solutions:
> 
> 1) Change the PowerPC device names from physical_address.device_name to 
> device_name.physical_address (so that e0102400.ucc becomes ucc.e0102400)

So then you'd get "firmware-ucc.e01024".  What if there's another ucc at 
  e0102480?  For devices with longer names, you'd have even less 
precision in the address.

-Scott
