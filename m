Return-Path: <khali@linux-fr.org>
Received: from mallaury.nerim.net (smtp-100-sunday.noc.nerim.net [62.4.17.100])
	by ozlabs.org (Postfix) with ESMTP id 537EDDDDF3
	for <linuxppc-dev@ozlabs.org>; Sun, 20 May 2007 21:42:18 +1000 (EST)
Date: Sun, 20 May 2007 13:42:43 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [i2c] [PATCH 3/5] powerpc: Document device nodes for I2C devices.
Message-ID: <20070520134243.0a6f9373@hyperion.delvare>
In-Reply-To: <6F8D3143-423D-45FA-9F40-00BF770831F2@kernel.crashing.org>
References: <20070517143846.GC29795@ld0162-tx32.am.freescale.net>
	<FB8DD3C1-A095-4ABB-9E74-7EC66A43D983@kernel.crashing.org>
	<464C800C.20400@freescale.com>
	<FFBD3A3A-ADBE-4DC8-A1A1-4163367244D5@kernel.crashing.org>
	<464C871C.4090300@freescale.com>
	<5B363A90-5528-4441-BBF9-9C6D8833D938@kernel.crashing.org>
	<20070518171555.543f9bdc@hyperion.delvare>
	<D50C4D36-CEA5-4F7F-8A4C-CC747DF85865@kernel.crashing.org>
	<464DD5E3.1060301@freescale.com>
	<6F8D3143-423D-45FA-9F40-00BF770831F2@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 18 May 2007 12:10:18 -0500, Kumar Gala wrote:
> For I2C specifically we already have both a dynamic way (kernel cmd  
> line) and static (i2c_board_info) to specify the i2c devices, why do  
> we need yet another?

This reminds me that the new-style drivers lost the ability to specify
i2c devices on the kernel command line. I wonder if it will be a
problem in practice. I planned to create a sysfs interface as a
replacement but never took the time to actually implement it.

-- 
Jean Delvare
