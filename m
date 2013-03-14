Return-Path: <paulus@ozlabs.org>
Date: Thu, 14 Mar 2013 20:02:29 +1100
From: Paul Mackerras <paulus@samba.org>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH 8/11] Update numa cpu vdso info
Message-ID: <20130314090228.GF9841@iris.ozlabs.ibm.com>
References: <513AB2E3.6090209@linux.vnet.ibm.com>
 <513AB569.1040106@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <513AB569.1040106@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 08, 2013 at 10:07:05PM -0600, Nathan Fontenot wrote:
> From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
> 
> The following patch adds vdso_getcpu_init(), which stores the NUMA node for
> a cpu in SPRG3:
> 
> http://patchwork.ozlabs.org/patch/169070/

Since that patch is now upstream, it would be better to refer to it by
its git SHA1 ID and title, like this:

Commit 18ad51dd34 ("powerpc: Add VDSO version of getcpu") adds
vdso_getcpu_init(), which stores the NUMA node for a cpu in SPRG3.

Paul.
