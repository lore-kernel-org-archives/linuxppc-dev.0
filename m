Return-Path: <paulus@ozlabs.org>
Date: Mon, 3 May 2010 15:04:47 +1000
From: Paul Mackerras <paulus@samba.org>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 1/2] PPC64-HWBKPT: Disable interrupts for data
	breakpoint exceptions
Message-ID: <20100503050447.GA19365@drongo>
References: <20100414033555.746326035@pr>
 <20100414034809.GB6571@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100414034809.GB6571@in.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, shaggy@linux.vnet.ibm.com,
	Frederic Weisbecker <fweisbec@gmail.com>, David Gibson <dwg@au1.ibm.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Alan Stern <stern@rowland.harvard.edu>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 14, 2010 at 09:18:09AM +0530, K.Prasad wrote:

> Data address breakpoint exceptions are currently handled along with page-faults
> which require interrupts to remain in enabled state. Since exception handling
> for data breakpoints aren't pre-empt safe, we handle them separately.
> 
> Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>

Acked-by: Paul Mackerras <paulus@samba.org>
