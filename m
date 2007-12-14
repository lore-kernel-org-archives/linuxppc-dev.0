Return-Path: <timur@freescale.com>
Message-ID: <476307BD.5010809@freescale.com>
Date: Fri, 14 Dec 2007 16:46:21 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
Subject: Re: Fix Firmware class name collision
References: <4755E6AC.9020808@freescale.com>
	<4755E835.6070704@freescale.com>	<4755FEA0.1050005@freescale.com>
	<20071214224051.GA29580@suse.de>
In-Reply-To: <20071214224051.GA29580@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Greg KH wrote:

> In the near future (2.6.26) there will not be a limit on the size of the
> file name, so we should not have this problem anymore.

In that case, I won't worry about it.  I would have preferred 2.6.25, since I 
have code going into 2.6.25 that is affected by the current limit.

-- 
Timur Tabi
Linux kernel developer at Freescale
