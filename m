Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by ozlabs.org (Postfix) with ESMTP id 9322D2C0104
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Sep 2013 06:32:48 +1000 (EST)
Received: from mail-vc0-f173.google.com (mail-vc0-f173.google.com
 [209.85.220.173])
 by muin.pair.com (Postfix) with ESMTPSA id 5C73D8FC12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Sep 2013 16:32:46 -0400 (EDT)
Received: by mail-vc0-f173.google.com with SMTP id if17so6602408vcb.32
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Sep 2013 13:32:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1379581205-24424-1-git-send-email-prabhakar@freescale.com>
References: <1379581205-24424-1-git-send-email-prabhakar@freescale.com>
Date: Thu, 19 Sep 2013 15:32:45 -0500
Message-ID: <CAOZdJXVBV0LvEwTua_eyTHXJdOcHZKQCjiTrYocqfcQY5hosUw@mail.gmail.com>
Subject: Re: [PATCH 1/2][v3] powerpc/fsl-booke: Add initial T104x_QDS board
 support
From: Timur Tabi <timur@tabi.org>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>,
 Priyanka Jain <Priyanka.Jain@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Poonam Aggrwal <poonam.aggrwal@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 19, 2013 at 4:00 AM, Prabhakar Kushwaha
<prabhakar@freescale.com> wrote:

>  - Video
>      - DIU supports video at up to 1280x1024x32bpp

You mention DIU support, except there's no DIU enablement in the
platform file.  You need the T104x equivalent of
p1022ds_set_pixel_clock() and the other functions.
