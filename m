Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17545.11572.518355.586057@cargo.ozlabs.ibm.com>
Date: Fri, 9 Jun 2006 18:11:32 +1000
From: Paul Mackerras <paulus@samba.org>
To: Olaf Hering <olh@suse.de>
Subject: Re: [PATCH] force 64bit mode in system_reset_fwnmi for broken POWER4
	firmware
In-Reply-To: <20060523130717.GA22364@suse.de>
References: <20060522164111.GA14462@suse.de> <20060523130717.GA22364@suse.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering writes:

> The reason is that system_reset_fwnmi is called in 32bit mode. Forcing
> 64bit mode fixes the corrupt NIP for me. JS20 and p690 are affected,
> seems to work on p550 and JS21.

What was the LTC bugzilla number for this again?

Paul.
