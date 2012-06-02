Return-Path: <paulus@ozlabs.org>
Date: Sat, 2 Jun 2012 16:14:27 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH 18/27] powerpc, smpboot: Use generic SMP booting
 infrastructure
Message-ID: <20120602061427.GA14048@pale.ozlabs.ibm.com>
References: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com>
 <20120601091417.31979.6433.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120601091417.31979.6433.stgit@srivatsabhat.in.ibm.com>
Cc: linux-arch@vger.kernel.org,
 "Nikunj A. Dadhania" <nikunj@linux.vnet.ibm.com>,
 Yong Zhang <yong.zhang0@gmail.com>, peterz@infradead.org,
 rusty@rustcorp.com.au, vatsa@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 rjw@sisk.pl, Paul Gortmaker <paul.gortmaker@windriver.com>, mingo@kernel.org,
 tglx@linutronix.de, paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 01, 2012 at 02:44:23PM +0530, Srivatsa S. Bhat wrote:
> From: Nikunj A. Dadhania <nikunj@linux.vnet.ibm.com>
> 
> Convert powerpc to use the generic framework to boot secondary CPUs.
> 
> Signed-off-by: Nikunj A. Dadhania <nikunj@linux.vnet.ibm.com>

Acked-by: Paul Mackerras <paulus@samba.org>
