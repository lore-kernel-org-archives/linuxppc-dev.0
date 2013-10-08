Return-Path: <michael@ellerman.id.au>
Date: Tue, 8 Oct 2013 15:17:02 +1100
From: Michael Ellerman <michael@ellerman.id.au>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] powerpc/kernel/sysfs: cleanup set up macros for
 PMC/non-PMC SPRs
Message-ID: <20131008041702.GD31666@concordia>
References: <1380792456-19128-1-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380792456-19128-1-git-send-email-maddy@linux.vnet.ibm.com>
Cc: olof@lixom.net, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 03, 2013 at 02:57:35PM +0530, Madhavan Srinivasan wrote:
> Currently PMC (Performance Monitor Counter) setup macros are used
> for other SPRs. Since not all SPRs are PMC related, this patch
> modifies the exisiting macro and uses it to setup both PMC and
> non PMC SPRs accordingly.
> 
> V3 changes:
> 
> 1) No logic change, just renamed generic macro and removed #define for empty string
> 2) Changes in the comment to explain better.
> 
> V2 changes:
> 
> 1) Modified SYSFS_PMCSETUP to a generic macro with additional parameter
> 2) Added PMC and SPR macro to call the generic macro
> 3) Changes in the comment to explain better.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Acked-by: Michael Ellerman <michael@ellerman.id.au>

Thanks for putting up with all the bike-shedding.

cheers
