Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [patch 2/2] cell: add support for power button of
	future IBM cell blades
Date: Tue, 15 Jul 2008 17:18:08 +0200
References: <20080715142529.837984547@de.ibm.com>
	<20080715162755.453c9b52@de.ibm.com>
In-Reply-To: <20080715162755.453c9b52@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807151718.08866.arnd@arndb.de>
Cc: krafft@de.ibm.com, lohausen@de.ibm.com, willeke@de.ibm.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 15 July 2008, krafft@de.ibm.com wrote:
> From: Christian Krafft <krafft@de.ibm.com>
> 
> This patch adds support for the power button on future IBM cell blades.
> It actually doesn't shut down the machine. Instead it exposes an
> input device /dev/input/event0 to userspace which sends KEY_POWER
> if power button has been pressed.
> haldaemon actually recognizes the button, so a plattform independent acpid
> replacement should handle it correctly.
> 
> Signed-off-by: Christian Krafft <krafft@de.ibm.com>
> 

Thanks, applied.

Note: this patch is line-wrapped, but I'll fix it up for you one more time ;-)
