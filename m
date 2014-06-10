Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [patch] powerpc/spufs: remove duplicate SPUFS_CNTL_MAP_SIZE define
Date: Tue, 10 Jun 2014 09:55:06 +0200
Message-ID: <4266625.8yXnFnBjUA@wuerfel>
In-Reply-To: <20140609151917.GM9600@mwanda>
References: <20140609151917.GM9600@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: cbe-oss-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 kernel-janitors@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>,
 Dan Carpenter <dan.carpenter@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 09 June 2014 18:19:17 Dan Carpenter wrote:
> The SPUFS_CNTL_MAP_SIZE define is cut and pasted twice so we can delete
> the second instance.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
