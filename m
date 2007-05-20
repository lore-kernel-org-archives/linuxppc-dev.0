Return-Path: <khali@linux-fr.org>
Received: from mallaury.nerim.net (smtp-100-sunday.noc.nerim.net [62.4.17.100])
	by ozlabs.org (Postfix) with ESMTP id D97A6DDE2A
	for <linuxppc-dev@ozlabs.org>; Sun, 20 May 2007 21:53:25 +1000 (EST)
Date: Sun, 20 May 2007 13:53:53 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [i2c] [PATCH 3/5] powerpc: Document device nodes for I2C devices.
Message-ID: <20070520135353.6b4dba0b@hyperion.delvare>
In-Reply-To: <464DE8A1.6050908@freescale.com>
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
	<464DDFA5.6050106@freescale.com>
	<79CACFC8-DD5B-4284-AC2E-C92FE2A85330@kernel.crashing.org>
	<464DE8A1.6050908@freescale.com>
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

Hi Scott,

On Fri, 18 May 2007 12:55:45 -0500, Scott Wood wrote:
> Fair enough.  I'm still interested in what you think would need to be 
> done to support switches and muxes, from the context of standardizing it 
> in ePAPR.  The bus numbering shouldn't be an issue as long as you keep 
> the bus numbers local to the switch/mux, and don't pretend that they 
> have anything to do with any global i2c bus number that the OS may or 
> may not have.

But then you cannot declare devices on these segments and expect Linux
to instantiate them. You'll have to wait for the segments to be created
and only then you'll be able to create the devices on them (using
i2c_new_device()).

Also, what's the point of giving numbers to the segments in the first
place, if they don't correspond to anything?

-- 
Jean Delvare
