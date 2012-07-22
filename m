Return-Path: <paulus@ozlabs.org>
Date: Mon, 23 Jul 2012 09:57:19 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V3 06/11] arch/powerpc: Make KERN_VIRT_SIZE not
 dependend on PGTABLE_RANGE
Message-ID: <20120722235719.GF17790@bloggs.ozlabs.ibm.com>
References: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1341839621-28332-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1341839621-28332-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 09, 2012 at 06:43:36PM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> As we keep increasing PGTABLE_RANGE we need not increase the virual
> map area for kernel.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Reviewed-by: Paul Mackerras <paulus@samba.org>
