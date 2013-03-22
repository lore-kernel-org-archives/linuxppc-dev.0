Return-Path: <michael@ellerman.id.au>
Date: Fri, 22 Mar 2013 15:18:03 +1100
From: Michael Ellerman <michael@ellerman.id.au>
To: Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [PATCH] powerpc: Add accounting for Doorbell interrupts
Message-ID: <20130322041803.GB26908@concordia>
References: <1363765332-28461-1-git-send-email-imunsie@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363765332-28461-1-git-send-email-imunsie@au1.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 20, 2013 at 06:42:12PM +1100, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> This patch adds a new line to /proc/interrupts to account for the
> doorbell interrupts that each hardware thread has received. The total
> interrupt count in /proc/stat will now also include doorbells.

Should it be inside CONFIG_PPC_DOORBELL ?

cheers
