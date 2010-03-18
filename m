Return-Path: <micha@neli.hopto.org>
Received: from edu-smtp-01.edutel.nl (edu-smtp-01.edutel.nl [88.159.1.221])
	by ozlabs.org (Postfix) with ESMTP id A4B4EB7CFC
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Mar 2010 18:25:07 +1100 (EST)
Message-ID: <4BA1D00F.1090809@neli.hopto.org>
Date: Thu, 18 Mar 2010 08:02:39 +0100
From: Micha Nelissen <micha@neli.hopto.org>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/fsl-booke: Get coherent bit from PTE
References: <1268800916-14247-1-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1268800916-14247-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> We shouldn't be always setting 'M' in the TLB entry since its reasonable
> for somethings to be mapped non-coherent.  The PTE should have 'M' set
> properly.

properly = not at all? AFAICS the patch only removes the setting of the 
bit; so where is that 'M' bit set then?

Micha
