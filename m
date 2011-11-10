Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from blv-smtpout-01.boeing.com (blv-smtpout-01.boeing.com
 [130.76.32.69])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "blv-smtpout-01.boeing.com",
 Issuer "VeriSign Class 3 International Server CA - G3" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 875A9100911
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2011 03:33:28 +1100 (EST)
From: "Moffett, Kyle D" <Kyle.D.Moffett@boeing.com>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Thu, 10 Nov 2011 10:33:21 -0600
Subject: Re: [RFC PATCH 04/17] powerpc: Allow multiple machine-check handlers
Message-ID: <2806AFF9-4F67-4846-95F6-D4093EA351A5@boeing.com>
References: <4E42AB6F.1050900@freescale.com>
 <1320883635-17194-5-git-send-email-Kyle.D.Moffett@boeing.com>
 <C3C78EA9-9E3D-46AC-94D0-537348DCFC64@kernel.crashing.org>
In-Reply-To: <C3C78EA9-9E3D-46AC-94D0-537348DCFC64@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Baruch Siach <baruch@tkos.co.il>, Timur Tabi <B04825@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Nov 10, 2011, at 08:37, Kumar Gala wrote:
> On Nov 9, 2011, at 6:07 PM, Kyle Moffett wrote:
>>=20
>> +#if defined(CONFIG_FSL_E500MC) || defined(CONFIG_FSL_E5500)
>> +#ifdef CONFIG_FSL_E500_V1_V2
>=20
> doesn't exist yet, so patch is wrong sequence order.

Oops, d'oh.

You are completely correct, thanks for noticing!

I'll fix this for my next submission.

Cheers,
Kyle Moffett
