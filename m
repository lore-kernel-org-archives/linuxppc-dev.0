Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [patch 1/2] cell: cleanup sysreset_hack for IBM
	cell blades
Date: Tue, 15 Jul 2008 17:17:24 +0200
References: <20080715142529.837984547@de.ibm.com>
	<20080715162757.75f06cf5@de.ibm.com>
In-Reply-To: <20080715162757.75f06cf5@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807151717.24754.arnd@arndb.de>
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
> This patch adds a config option for the sysreset_hack used for
> IBM Cell blades. The code is moves from pervasive.c into ras.c and
> gets it's own init method.
> 
> Signed-off-by: Christian Krafft <krafft@de.ibm.com>
> 

thanks, applied
