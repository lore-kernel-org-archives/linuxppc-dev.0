Return-Path: <tmarri@apm.com>
Received: from exprod5og103.obsmtp.com (exprod5og103.obsmtp.com [64.18.0.145])
 by ozlabs.org (Postfix) with SMTP id DC8911007D8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2011 11:25:28 +1100 (EST)
Received: by qabj40 with SMTP id j40so4369747qab.33
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2011 17:25:25 -0700 (PDT)
From: Tirumala Marri <tmarri@apm.com>
References: <1318630114-14064-1-git-send-email-tmarri@apm.com>
 <20111021173302.GB27652@quad.lixom.net>
 <c898f5030d342baa4df570317536bcf2@mail.gmail.com>
 <CAOesGMhVuxbqq7cmm2XVUof9vEifAL=GpPirYb8148a24upJCw@mail.gmail.com>
 <0a2f495d6415e9cad48ae2c75c582e0d@mail.gmail.com>
 <20111027045103.GA609@kroah.com>
In-Reply-To: <20111027045103.GA609@kroah.com>
MIME-Version: 1.0
Date: Thu, 27 Oct 2011 17:25:23 -0700
Message-ID: <78a0754457fe7cd128521229da2f5d80@mail.gmail.com>
Subject: RE: [PATCH v15 00/10] Add-Synopsys-DesignWare-HS-USB-OTG-driver
To: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
>What email client are you using, I have never seen this type of
>formatting, and it makes it impossible to read your replies.  Please
>resolve this.
Wrong prefix setting. Should be fixed now.

>Sometimes people miss things on previous reviews, this is not a perfict
>system, only the best that we currently know how to do, don't you agree?
>
>If this driver contains lots of things that are not necessary for it to
>work at this point in time, why wouldn't that be removed now?
>
>Anyway, I think it would probably be best to get this into staging for
>now, which will help you get a way to clean it up in an easier manner,
>and still have users have access to it.  Is that acceptable?
>
Yes it would be great if it can make it to staging. I will try remove
The un used code and re-send the patch.

Thx,
Marri
