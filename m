Return-Path: <michael@ellerman.id.au>
Message-ID: <1359948565.25414.12.camel@concordia>
Subject: Re: [PATCH] powerpc/mm: Fix hash computation function
From: Michael Ellerman <michael@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Mon, 04 Feb 2013 14:29:25 +1100
In-Reply-To: <1359524442-5861-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1359524442-5861-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Mike Qiu <qiudayu@linux.vnet.ibm.com>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-01-30 at 11:10 +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> The ASM version of hash computation function was truncating the upper bit.
> Make the ASM version similar to hpt_hash function. Remove masking vsid bits.
> Without this patch, we observed hang during bootup due to not satisfying page
> fault request correctly.

Which commit(s) introduced the bug?

cheers
