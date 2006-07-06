Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17581.40865.169428.154793@cargo.ozlabs.ibm.com>
Date: Fri, 7 Jul 2006 09:41:21 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH 4/20] Mark platform device data as const
In-Reply-To: <45499930@toto.iv>
Cc: linuxppc-dev@ozlabs.org, greg@kroah.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jeremy Kerr writes:

> platform_device_add_data()'s data argument can be qualified as const -
> the function just copies it to another buffer.

Ummm, you change the actual function definition here, but you put the
change to the declaration in include/linux/platform_device.h in your
[5/20] patch.  Please redo this patch with the change to the
declaration included.

Paul.
