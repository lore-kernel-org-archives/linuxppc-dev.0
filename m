Return-Path: <chen.gang.flying.transformer@gmail.com>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BE2282C00D7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Mar 2013 13:51:59 +1100 (EST)
Received: by mail-pa0-f45.google.com with SMTP id kl13so203121pab.32
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 19:51:57 -0700 (PDT)
Message-ID: <514D18A8.7080904@gmail.com>
Date: Sat, 23 Mar 2013 10:51:20 +0800
From: Chen Gang F T <chen.gang.flying.transformer@gmail.com>
MIME-Version: 1.0
To: Yoder Stuart-B08248 <B08248@freescale.com>
Subject: Re: [Suggestion] PowerPC: kernel: cross compiling issue with
 allmodconfig
References: <51428C81.6000204@asianux.com>
 <25841.1363323174@ale.ozlabs.ibm.com> <5142AE27.7060003@asianux.com>
 <514AA0D9.1090509@asianux.com> <514AC418.1070806@gmail.com>
 <14121.1363908062@ale.ozlabs.ibm.com>
 <9F6FE96B71CF29479FF1CDC8046E150358CDE5@039-SN1MPN1-002.039d.mgd.msft.net>
In-Reply-To: <9F6FE96B71CF29479FF1CDC8046E150358CDE5@039-SN1MPN1-002.039d.mgd.msft.net>
Content-Type: text/plain; charset=UTF-8
Cc: "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
 Michael Neuling <mikey@neuling.org>, "matt@ozlabs.org" <matt@ozlabs.org>,
 Chen Gang <gang.chen@asianux.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "imunsie@au1.ibm.com" <imunsie@au1.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2013年03月23日 03:17, Yoder Stuart-B08248 wrote:
> allmodconfig is creating config combinations that don't
> happen in a normal build (at least currently)-- 64-bit build
> that enables EPAPR_PARAVIRT but not PPC_BOOK3E_64.

  if it should not happen.
    can we add dependency to let it will never happen in any config combinations ?
      let allmodconfig can not create this config combinamtions:
        "64-bit build that enables EPAPR_PARAVIRT but not PPC_BOOK3E_64".

  thanks.

-- 
Chen Gang

Flying Transformer
