Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.242])
	by ozlabs.org (Postfix) with ESMTP id 0F48ADE303
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jun 2008 01:19:52 +1000 (EST)
Received: by ag-out-0708.google.com with SMTP id 8so3384475agc.0
	for <linuxppc-dev@ozlabs.org>; Fri, 06 Jun 2008 08:19:51 -0700 (PDT)
Message-ID: <fa686aa40806060819t75c1c0b0h303ff37d387b2373@mail.gmail.com>
Date: Fri, 6 Jun 2008 09:19:50 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [PATCH] phylib: Don't allow core of phylib to build as a module
In-Reply-To: <48448020.5020407@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <Pine.LNX.4.64.0806021019540.22439@blarg.am.freescale.net>
	<484419EE.5040503@garzik.org>
	<1E4EB64C-0618-497E-AABC-74EB7D74B97F@kernel.crashing.org>
	<48442239.7090906@garzik.org>
	<BF15FEBB-4876-4B16-915B-1D21BF989DA8@kernel.crashing.org>
	<83820D83-487C-4586-9867-F4226A87A276@freescale.com>
	<48445851.4090105@garzik.org>
	<095F258F-72DD-4F27-A457-A57D9FAA1E76@kernel.crashing.org>
	<48448020.5020407@freescale.com>
Cc: netdev@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 2, 2008 at 5:20 PM, Scott Wood <scottwood@freescale.com> wrote:
> Kumar Gala wrote:
>> I think we'd be better off with a small stub that is always built into the
>> kernel for phy_read/phy_write, etc or the function pointer indirection
>> mechanism.
>
> And then instead of build failures, you'd get a silent runtime failure to
> apply the workaround if phylib is built as a module.

Indeed; I vote for the build failure over the silent runtime failure.
If a platform needs it and does not select it, then the platform is
broken and it is a bug.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
