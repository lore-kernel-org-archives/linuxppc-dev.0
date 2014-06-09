Return-Path: <jk@ozlabs.org>
Message-ID: <53963EA3.4050400@ozlabs.org>
Date: Tue, 10 Jun 2014 09:09:23 +1000
From: Jeremy Kerr <jk@ozlabs.org>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] powerpc/spufs: remove duplicate SPUFS_CNTL_MAP_SIZE define
References: <20140609151917.GM9600@mwanda>
In-Reply-To: <20140609151917.GM9600@mwanda>
Content-Type: text/plain; charset=ISO-8859-1
Cc: cbe-oss-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
 kernel-janitors@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Dan,

> The SPUFS_CNTL_MAP_SIZE define is cut and pasted twice so we can delete
> the second instance.

Looks good to me.

Acked-by: Jeremy Kerr <jk@ozlabs.org>

Cheers,


Jeremy
