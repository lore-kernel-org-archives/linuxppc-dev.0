Return-Path: <dgibson@ozlabs.org>
Date: Mon, 24 Sep 2007 12:59:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 2/15] boot: record header bytes in gunzip_start
Message-ID: <20070924025925.GE8058@localhost.localdomain>
References: <boot-8-00.miltonm@bga.com> <boot-8-02.miltonm@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <boot-8-02.miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Rob Landley <rob@landley.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 21, 2007 at 06:03:34PM -0500, Milton Miller wrote:
> 
> Record the number of header bytes skipped in the total bytes read field.
> 
> This is needed for the initramfs parsing code to find the end of the
> zip file.
> 
> Signed-off-by: Milton Miller <miltonm@bga.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
