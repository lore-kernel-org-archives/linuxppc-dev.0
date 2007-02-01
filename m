Return-Path: <jens@de.ibm.com>
From: Jens Osterkamp <jens@de.ibm.com>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH] spidernet : fix memory leak in spider_net_stop
Date: Thu, 1 Feb 2007 21:40:10 +0100
References: <200702011207.47421.jens@de.ibm.com>
	<20070201173618.GI5616@austin.ibm.com>
In-Reply-To: <20070201173618.GI5616@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702012140.10877.jens@de.ibm.com>
Cc: netdev@vger.kernel.org, cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
	jgarzik@pobox.com, James K Lewis <jim@jklewis.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 01 February 2007 6:36 pm, Linas Vepstas wrote:
> 
> A variant of this patch is queued up for 2.6.21,
> as a part of the patch
> http://www.mail-archive.com/netdev@vger.kernel.org/msg28213.html
> 
> I beleive its in the -mm tree, I have not checked.

Ah, good ! I knew that you had several patches in the queue but wasnt aware
of the detailed content.

Jens
