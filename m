Return-Path: <hch@lst.de>
Date: Fri, 4 Apr 2008 02:12:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Osterkamp <jens@de.ibm.com>
Subject: Re: [PATCH] RTAS - adapt procfs interface
Message-ID: <20080404001242.GA19506@lst.de>
References: <200804011512.20834.jens@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200804011512.20834.jens@de.ibm.com>
Cc: maxim@de.ibm.com, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 01, 2008 at 03:12:20PM +0200, Jens Osterkamp wrote:
> 
> Hi,
> 
> rtas_flash was broken since 2.6.24-rc5. This patch fixes it.
> I think this is a good bugfix candidate for 2.6.25.

NACK.  driver should not poke into the internal count member.  Just
provide your own inclusion with a new counter or set/test_bit.
