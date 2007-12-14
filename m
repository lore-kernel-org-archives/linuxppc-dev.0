Return-Path: <gregkh@suse.de>
Date: Fri, 14 Dec 2007 14:40:51 -0800
From: Greg KH <gregkh@suse.de>
To: Timur Tabi <timur@freescale.com>
Subject: Re: Fix Firmware class name collision
Message-ID: <20071214224051.GA29580@suse.de>
References: <4755E6AC.9020808@freescale.com> <4755E835.6070704@freescale.com>
	<4755FEA0.1050005@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4755FEA0.1050005@freescale.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>,
	Markus Rechberger <markus.rechberger@amd.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 04, 2007 at 07:28:00PM -0600, Timur Tabi wrote:
> Scott Wood wrote:
>
>> The physical address certainly is useful when you have more than one 
>> device of the same name.
>
> What I meant was that the physical address isn't helpful by itself.
>
>> So then you'd get "firmware-ucc.e01024".  What if there's another ucc at  
>> e0102480?  For devices with longer names, you'd have even less precision 
>> in the address.
>
> Maybe we need to consider a more sophisticated algorithm, one that 
> guarantees that the device name in its entirety is preserved?  Either that, 
> or replace the physical address with something shorter, like the offset to 
> the root node only?  That way, ucc.e0102400 because just ucc.2400.

You should do something :)

In the near future (2.6.26) there will not be a limit on the size of the
file name, so we should not have this problem anymore.

thanks,

greg k-h
