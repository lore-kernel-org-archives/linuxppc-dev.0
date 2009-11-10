Return-Path: <nfont@austin.ibm.com>
Message-ID: <4AF9CE2F.7080502@austin.ibm.com>
Date: Tue, 10 Nov 2009 14:33:51 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 09/11] of: merge prom_{add,remove,modify}_property
References: <20091105073728.10460.6061.stgit@angua>
	<20091105074656.10460.29333.stgit@angua>
In-Reply-To: <20091105074656.10460.29333.stgit@angua>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, devicetree-discuss@lists.ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> Merge common code between PowerPC and MicroBlaze
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> 
>  arch/microblaze/kernel/prom.c |  113 ----------------------------------------
>  arch/powerpc/kernel/prom.c    |  114 ----------------------------------------
>  drivers/of/base.c             |  116 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 116 insertions(+), 227 deletions(-)
> 

Should the prom_{add,remove,update}_property routines belong in base.c or
of_dynamic.c (patches coming soon for of_dynamic.c)?  

My original patch set put these routines in of_dynamic.c and renamed
them to of_{add,remove,update}_property since they are part of the of
code.

-Nathan Fontenot
