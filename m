Return-Path: <b07421@freescale.com>
Date: Thu, 5 Apr 2007 11:11:13 -0500
From: Scott Wood <scottwood@freescale.com>
To: Jerry Van Baren <gvb.uboot@gmail.com>
Subject: Re: [PATCH dtc] Implement the -R option and add a -S option.
Message-ID: <20070405161113.GA28063@ld0162-tx32.am.freescale.net>
References: <20070405020433.GA13891@dellserver.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070405020433.GA13891@dellserver.lan>
Cc: Linuxppc-dev@ozlabs.org, jdl@jdl.com, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 04, 2007 at 10:04:33PM -0400, Jerry Van Baren wrote:
> Implement the -R <number> option to add memory reserve slots.
> Add a -S <size> option makes the blob at least this number of bytes.

Wouldn't it be better to just specify the amount of extra space, instead
of the minimum total space?  That way, you only need to know what you
intend to add, not how much is already there.

-Scott
