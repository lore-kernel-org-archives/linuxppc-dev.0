Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18085.59414.38125.30777@cargo.ozlabs.ibm.com>
Date: Tue, 24 Jul 2007 21:52:54 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 21/25] [POWERPC] 85xxCDS: Delay 8259 cascade hookup.
In-Reply-To: <11852238432011-git-send-email-galak@kernel.crashing.org>
References: <11852238122538-git-send-email-galak@kernel.crashing.org>
	<1185223813693-git-send-email-galak@kernel.crashing.org>
	<11852238151983-git-send-email-galak@kernel.crashing.org>
	<11852238161546-git-send-email-galak@kernel.crashing.org>
	<1185223818821-git-send-email-galak@kernel.crashing.org>
	<11852238193371-git-send-email-galak@kernel.crashing.org>
	<1185223821183-git-send-email-galak@kernel.crashing.org>
	<11852238233066-git-send-email-galak@kernel.crashing.org>
	<11852238241475-git-send-email-galak@kernel.crashing.org>
	<11852238253550-git-send-email-galak@kernel.crashing.org>
	<11852238271141-git-send-email-galak@kernel.crashing.org>
	<11852238283648-git-send-email-galak@kernel.crashing.org>
	<1185223830411-git-send-email-galak@kernel.crashing.org>
	<11852238322319-git-send-email-galak@kernel.crashing.org>
	<11852238333649-git-send-email-galak@kernel.crashing.org>
	<11852238353292-git-send-email-galak@kernel.crashing.org>
	<11852238362041-git-send-email-galak@kernel.crashing.org>
	<11852238383453-git-send-email-galak@kernel.crashing.org>
	<11852238392809-git-send-email-galak@kernel.crashing.org>
	<11852238411823-git-send-email-galak@kernel.crashing.org>
	<11852238421611-git-send-email-galak@kernel.crashing.org>
	<11852238432011-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> From: Randy Vinson <rvinson@mvista.com>

> +device_initcall(mpc85xx_cds_8259_attach);

I don't see any platform test in mpc85xx_cds_8259_attach to make sure
it only does its stuff on suitable platforms.  Looks like it needs
one.

Paul.
