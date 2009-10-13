Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CD048B7B9D
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2009 20:32:49 +1100 (EST)
Subject: Re: i2c-powermac fails
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jean Delvare <khali@linux-fr.org>
In-Reply-To: <20091013112304.74083fd1@hyperion.delvare>
References: <20091013112304.74083fd1@hyperion.delvare>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Oct 2009 20:32:28 +1100
Message-Id: <1255426348.2192.187.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Tim Shepard <shep@alum.mit.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-10-13 at 11:23 +0200, Jean Delvare wrote:
> Hi Ben, Paul,
> 
> I had a report by Tim Shepard (Cc'd) that the therm_adt746x driver
> sometimes fails to initialize on his PowerBook G4 running kernel
> 2.6.31. The following error message can be seen in the logs when the
> failure happens:
> 
> therm_adt746x 7-002e: Thermostat failed to read config!
> 
> After enabling low-level i2c debugging, it turns out that the problem
> is caused by low-level errors at the I2C bus level:

Nothing comes to mind immediately, but I'll have another look tomorrow.

Maybe we are configuring the i2c bus too fast ? Another possibility
would be that the device needs some retries ...

Ben.
