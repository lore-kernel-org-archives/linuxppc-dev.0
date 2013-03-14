Return-Path: <paulus@ozlabs.org>
Date: Thu, 14 Mar 2013 19:52:19 +1100
From: Paul Mackerras <paulus@samba.org>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/11] Move architecture vector definitions to prom.h
Message-ID: <20130314085219.GC9841@iris.ozlabs.ibm.com>
References: <513AB2E3.6090209@linux.vnet.ibm.com>
 <513AB415.2040006@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <513AB415.2040006@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 08, 2013 at 10:01:25PM -0600, Nathan Fontenot wrote:
> As part of handling of handling PRRN events we will need to check the
> vector 5 portion of the architecture bits reported in the device tree
> to ensure that PRRN event handling is enabled. In order to do this a
> new platform_has_feature call is introduced (in a subsequent patch) to
> make this check.  To avoid having to re-define bits in the architecture
> vector the bits are moved to prom.h.
> 
> This patch is the first step in implementing the platform_has_feature
> call by simply moving the bit definitions from prom_init.c to asm/prom.h.
> There are no functional.
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Acked-by: Paul Mackerras <paulus@samba.org>
