Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2] cell: move SPU affinity init to spu_management_of_ops
Date: Sat, 4 Aug 2007 09:25:48 +0200
References: <200707252342.50244.adetsch@br.ibm.com> <46B3DC2A.408@am.sony.com>
In-Reply-To: <46B3DC2A.408@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708040925.49098.arnd@arndb.de>
Cc: Andre Detsch <adetsch@br.ibm.com>, Paul Mackerras <paulus@samba.org>,
	hch@lst.de, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 04 August 2007, Geoff Levand wrote:
> 
> From: Andre Detsch <adetsch@br.ibm.com>
> 
> This patch moves affinity initialization code from spu_base.c to a
> new spu_management_of_ops function (init_affinity), which is empty
> in the case of PS3. This fixes a linking problem that was happening
> when compiling for PS3.
> Also, some small code style changes were made.
> 
> Signed-off-by: Andre Detsch <adetsch@br.ibm.com>
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>


Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
