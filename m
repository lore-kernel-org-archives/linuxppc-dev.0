Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6C3102C0087
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 20:41:06 +1000 (EST)
Message-ID: <52440F00.702@asianux.com>
Date: Thu, 26 Sep 2013 18:40:00 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] sound/soc/fsl/fsl_ssi.c: let check zero instead of
 check NO_IRQ
References: <523FB47C.8010800@asianux.com> <523FB6F4.60803@asianux.com>
 <523FB735.2060906@asianux.com> <20130926102914.GG19304@sirena.org.uk>
In-Reply-To: <20130926102914.GG19304@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 lgirdwood@gmail.com, perex@perex.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/26/2013 06:29 PM, Mark Brown wrote:
> On Mon, Sep 23, 2013 at 11:36:21AM +0800, Chen Gang wrote:
>> NO_IRQ may be defined as '(unsigned int) -1' in some architectures
>> (arm, sh ...), and either may not be defined in some architectures
>> which can enable SND_SOC_FSL_SSI (e.g. allmodconfig for arc).
> 
> Applied, thanks.
> 

Thank you too.  :-)

-- 
Chen Gang
