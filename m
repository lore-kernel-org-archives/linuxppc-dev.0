Return-Path: <htejun@gmail.com>
Received: from mail-qc0-x233.google.com (mail-qc0-x233.google.com
 [IPv6:2607:f8b0:400d:c01::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C81292C00D1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 22:39:42 +1000 (EST)
Received: by mail-qc0-f179.google.com with SMTP id n10so155727qcx.24
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 05:39:39 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 20 Aug 2013 08:39:36 -0400
From: Tejun Heo <tj@kernel.org>
To: Anthony Foiani <anthony.foiani@gmail.com>
Subject: Re: [PATCH] sata: fsl: save irqs while coalescing
Message-ID: <20130820123936.GD3926@htj.dyndns.org>
References: <gsiy6olhp.fsf@dworkin.scrye.com>
 <1376961630-6255-1-git-send-email-anthony.foiani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1376961630-6255-1-git-send-email-anthony.foiani@gmail.com>
Cc: Anthony Foiani <tkil@scrye.com>, linux-ide@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Scott Wood <scottwood@freescale.com>,
 Bhushan Bharat-R65777 <R65777@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 19, 2013 at 07:20:30PM -0600, Anthony Foiani wrote:
> This patch is based off linux-next tag next-20130819
> (which is commit 66a01bae29d11916c09f9f5a937cafe7d402e4a5 )
> 
> Signed-off-by: Anthony Foiani <anthony.foiani@gmail.com>

Applied to libata/for-3.11-fixes w/ stable cc'd.

Thanks.

-- 
tejun
