Return-Path: <pladow@gmail.com>
Received: from mail-lb0-x232.google.com (mail-lb0-x232.google.com
 [IPv6:2a00:1450:4010:c04::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 639C92C0077
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 06:12:49 +1000 (EST)
Received: by mail-lb0-f178.google.com with SMTP id z5so2408835lbh.37
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Aug 2013 13:12:43 -0700 (PDT)
MIME-Version: 1.0
Sender: pladow@gmail.com
In-Reply-To: <20130805202559.0086e806@crub>
References: <CAN8Q1Ed-YtD1L7e9TaJyELdcz5Rcfdi0mdwU_H6HAx0-3FJ4Lg@mail.gmail.com>
 <20130805202559.0086e806@crub>
Date: Mon, 5 Aug 2013 13:12:43 -0700
Message-ID: <CAN8Q1EfoLTDr-x0r82Ezpqak+R=QuL1o37_OVU3Q0=8zFfDMqA@mail.gmail.com>
Subject: Re: Failure to detect PCI card
From: Peter LaDow <petela@gocougs.wsu.edu>
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 5, 2013 at 11:25 AM, Anatolij Gustschin <agust@denx.de> wrote:
> Maybe this card needs bigger delay to respond after PCI reset. You can
> try to re-build U-Boot with defined CONFIG_PCI_BOOTDELAY. Use 1000
> for CONFIG_PCI_BOOTDELAY in the first step and if detection works,
> try to decrease this value.

That didn't work.  But perhaps the problem is because these are older
PCI parts, and don't implement ECAM (only the older CAM)?   I don't
think u-boot limits itself...

Thanks,
Pete
