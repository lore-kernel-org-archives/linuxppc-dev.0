Return-Path: <paulus@ozlabs.org>
Date: Mon, 9 Sep 2013 15:36:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v3 06/12] powerpc/book3s: Add flush_tlb operation in
 cpu_spec.
Message-ID: <20130909053615.GF6248@drongo>
References: <20130826192616.2855.18749.stgit@mars>
 <20130826193204.2855.6506.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130826193204.2855.6506.stgit@mars>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 27, 2013 at 01:02:04AM +0530, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> This patch introduces flush_tlb operation in cpu_spec structure. This will
> help us to invoke appropriate CPU-side flush tlb routine. This patch
> adds the foundation to invoke CPU specific flush routine for respective
> architectures. Currently this patch introduce flush_tlb for p7 and p8.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Acked-by: Paul Mackerras <paulus@samba.org>
