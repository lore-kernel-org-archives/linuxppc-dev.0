Return-Path: <paulus@ozlabs.org>
Date: Wed, 8 Sep 2010 11:59:16 +1000
From: Paul Mackerras <paulus@samba.org>
To: Matthew McClintock <msm@freescale.com>
Subject: Re: [RFC] arch/powerpc: Remove duplicate/redundant Altivec entries
Message-ID: <20100908015916.GB17010@brick.ozlabs.ibm.com>
References: <1283885815-11175-1-git-send-email-msm@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1283885815-11175-1-git-send-email-msm@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 07, 2010 at 01:56:55PM -0500, Matthew McClintock wrote:

> In lieu of having multiple similiar lines, we can just have one
> generic cpu-as line for CONFIG_ALTIVEC
> 
> ---
> Was hoping to get comments about this change and if anyone sees any potential
> problems?

I have a memory that we can get some altivec instructions even with
CONFIG_ALTIVEC = n, though presumably they never get executed.  We
would have to check that before applying your patch.

Paul.
